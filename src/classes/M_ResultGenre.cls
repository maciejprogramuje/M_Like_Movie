public with sharing class M_ResultGenre {
    public static String endpoint = 'https://api.themoviedb.org/3';
    public static String apiKey = '2a226b222f0619bd09647e3c738cf7ee';

    @AuraEnabled
    public static M_ResponseMovie getMovies(String genre, Integer pageNo) {
        M_ResponseMovie tempResponseMovie = convertM_ResponseGenre2M_ResponseMovie(getMoviesFromDb(genre, pageNo));

        if (tempResponseMovie.total_pages == pageNo) {
            List<Movie_Inner_Db__c> moviesFromInnerDb = [
                    SELECT Id, Adult__c, Backdrop_Path__c, Is_Favorite__c, Is_Hated__c, Original_Language__c, Original_Title__c, Overview__c,
                            Popularity__c, Poster_Path__c, Release_Date__c, Title__c, Video__c, Vote_Average__c, Vote_Count__c, IdGenerated__c, Genre__c
                    FROM Movie_Inner_Db__c
                    WHERE Genre__c LIKE :genre AND isActive__c = true
            ];

            for (Movie_Inner_Db__c movieInnerDb : moviesFromInnerDb) {
                M_ResponseMovie.Results tempMovie = new M_ResponseMovie.Results();
                tempMovie.adult = movieInnerDb.Adult__c;
                tempMovie.backdrop_path = movieInnerDb.Backdrop_Path__c;

                tempMovie.id = Integer.valueOf(movieInnerDb.IdGenerated__c);

                tempMovie.original_language = movieInnerDb.Original_Language__c;
                tempMovie.original_title = movieInnerDb.Original_Title__c;
                tempMovie.overview = movieInnerDb.Overview__c;
                tempMovie.popularity = movieInnerDb.Popularity__c;
                tempMovie.poster_path = movieInnerDb.Poster_Path__c;

                tempMovie.poster_path = getProfilePicturePath(movieInnerDb.Id);
                if (tempMovie.poster_path != null) {
                    tempMovie.is_from_attachment = true;
                }

                tempMovie.release_date = movieInnerDb.Release_Date__c;
                tempMovie.title = movieInnerDb.Title__c;
                tempMovie.video = movieInnerDb.Video__c;
                tempMovie.vote_average = movieInnerDb.Vote_Average__c;
                tempMovie.vote_count = Integer.valueOf(movieInnerDb.Vote_Count__c);
                tempMovie.genre_ids = new List<String>{movieInnerDb.Genre__c};

                tempResponseMovie.results.add(tempMovie);
                tempResponseMovie.total_results = tempResponseMovie.total_results + 1;
            }
        }

        assignHated(tempResponseMovie);
        assignFavorite(tempResponseMovie);

        tempResponseMovie.results.sort();

        return tempResponseMovie;
    }


    @AuraEnabled
    public static String getProfilePicturePath(Id parentId) {
        List<Attachment> attachments = new List<Attachment>();
        attachments = [
                SELECT Id, Name, LastModifiedDate, ContentType
                FROM Attachment
                WHERE parentid = :ParentId AND ContentType IN ('image/png', 'image/jpeg', 'image/gif')
                ORDER BY LastModifiedDate DESC
                LIMIT 1
        ];
        System.debug('attachments >> ' + attachments);

        if (attachments.isEmpty()) {
            return null;
        } else {
            return attachments.get(0).Id;
        }
    }

    @AuraEnabled
    public static String addMovie(String addTitle, String addOriginalTitle, String addReleaseDate, String addOverview, String addGenre) {
        Movie_Inner_Db__c newMovie = new Movie_Inner_Db__c();
        newMovie.Title__c = addTitle;
        newMovie.Original_Title__c = addOriginalTitle;
        newMovie.Release_Date__c = addReleaseDate;
        newMovie.Overview__c = addOverview;
        newMovie.Genre__c = addGenre;

        Double d = math.random() * 2000000000;
        newMovie.IdGenerated__c = d.intValue();

        Database.SaveResult results = Database.insert(newMovie);

        return results.getId();
    }

    private static M_ResponseGenre getMoviesFromDb(String genre, Integer pageNo) {
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        Http http = new Http();
        HttpResponse res;

        req.setEndpoint(endpoint + '/discover/movie?api_key=' + apiKey + '&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=' + pageNo + '&with_genres=' + genre);

        try {
            res = http.send(req);

            M_ResponseGenre responseGenre = (M_ResponseGenre) JSON.deserialize(res.getBody(), M_ResponseGenre.class);

            return responseGenre;
        } catch (system.CalloutException e) {
            System.debug('error >>> ' + e);
        }

        return null;
    }

    private static void assignHated(M_ResponseMovie respMovies) {
        List<MovieExtras__c> hatedMovies = [SELECT Id, IdMovie__c FROM MovieExtras__c WHERE IsHate__c = TRUE];

        for (MovieExtras__c hatedMovie : hatedMovies) {
            for (M_ResponseMovie.Results result : respMovies.results) {
                if (String.valueOf(result.id).equals(hatedMovie.IdMovie__c)) {
                    result.is_hated = true;
                    break;
                }
            }
        }
    }

    private static void assignFavorite(M_ResponseMovie respMovies) {
        List<MovieExtras__c> favMovies = [SELECT Id, IdMovie__c FROM MovieExtras__c WHERE IsFavorite__c = TRUE];

        for (MovieExtras__c favMovie : favMovies) {
            for (M_ResponseMovie.Results result : respMovies.results) {
                if (String.valueOf(result.id).equals(favMovie.IdMovie__c)) {
                    result.is_favorite = true;
                    break;
                }
            }
        }
    }

    private static M_ResponseMovie convertM_ResponseGenre2M_ResponseMovie(M_ResponseGenre responseGenre) {
        M_ResponseMovie tempResponse = new M_ResponseMovie();
        tempResponse.total_pages = responseGenre.total_pages;
        tempResponse.total_results = responseGenre.total_results;
        tempResponse.page = responseGenre.page;

        List<M_ResponseMovie.Results> tempResults = new List<M_ResponseMovie.Results>();

        for(M_ResponseGenre.Result genreResult : responseGenre.results) {
            M_ResponseMovie.Results tempResult = new M_ResponseMovie.Results();
            tempResult.vote_count = genreResult.vote_count;
            tempResult.id = genreResult.id;
            tempResult.video = genreResult.video;
            tempResult.vote_average = genreResult.vote_average;
            tempResult.title = genreResult.title;
            tempResult.popularity = genreResult.popularity;
            tempResult.poster_path = genreResult.poster_path;
            tempResult.original_language = genreResult.original_language;
            tempResult.original_title = genreResult.original_title;
            //tempResult.genre_ids = genreResult.genres;
            tempResult.backdrop_path = genreResult.backdrop_path;
            tempResult.adult = genreResult.adult;
            tempResult.overview = genreResult.overview;
            tempResult.release_date = genreResult.release_date;

            tempResults.add(tempResult);
        }

        tempResponse.results = tempResults;

        return tempResponse;
    }
}