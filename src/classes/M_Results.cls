public with sharing class M_Results {
    public static String endpoint = 'https://api.themoviedb.org/3';
    public static String apiKey = '2a226b222f0619bd09647e3c738cf7ee';

    @AuraEnabled
    public static M_ResponseMovie getMovies(String title, Integer pageNo) {
        M_ResponseMovie tempResponseMovie = getMoviesFromDb(title, pageNo);

        if(tempResponseMovie.total_pages == pageNo) {
            String tempTitle = title + '%';

            List<Movie_Inner_Db__c> moviesFromInnerDb = [
                    SELECT Id, Adult__c, Backdrop_Path__c, Is_Favorite__c, Is_Hated__c, Original_Language__c, Original_Title__c, Overview__c,
                            Popularity__c, Poster_Path__c, Release_Date__c, Title__c, Video__c, Vote_Average__c, Vote_Count__c, IdGenerated__c
                    FROM Movie_Inner_Db__c
                    WHERE Title__c LIKE :tempTitle AND isActive__c = true
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
                if(tempMovie.poster_path != null) {
                    tempMovie.is_from_attachment = true;
                }

                tempMovie.release_date = movieInnerDb.Release_Date__c;
                tempMovie.title = movieInnerDb.Title__c;
                tempMovie.video = movieInnerDb.Video__c;
                tempMovie.vote_average = movieInnerDb.Vote_Average__c;
                tempMovie.vote_count = Integer.valueOf(movieInnerDb.Vote_Count__c);

                tempResponseMovie.results.add(tempMovie);
                tempResponseMovie.total_results = tempResponseMovie.total_results + 1;
            }
        }

        assignHated(tempResponseMovie);
        assignFavorite(tempResponseMovie);

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
    public static String addMovie(String addTitle, String addOriginalTitle, String addReleaseDate, String addOverview) {
        Movie_Inner_Db__c newMovie = new Movie_Inner_Db__c();
        newMovie.Title__c = addTitle;
        newMovie.Original_Title__c = addOriginalTitle;
        newMovie.Release_Date__c = addReleaseDate;
        newMovie.Overview__c = addOverview;

        Double d = math.random() * 2000000000;
        newMovie.IdGenerated__c = d.intValue();

        Database.SaveResult results = Database.insert(newMovie);

        return results.getId();
    }

    private static M_ResponseMovie getMoviesFromDb(String title, Integer pageNo) {
        title = title.replaceAll(' ', '%20');

        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        Http http = new Http();
        HttpResponse res;

        req.setEndpoint(endpoint + '/search/movie?api_key=' + apiKey + '&language=en-US&query=' + title + '&page=' + pageNo + '&include_adult=false');
        try {
            res = http.send(req);

            M_ResponseMovie responseMovie = (M_ResponseMovie) JSON.deserialize(res.getBody(), M_ResponseMovie.class);

            return responseMovie;
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
}