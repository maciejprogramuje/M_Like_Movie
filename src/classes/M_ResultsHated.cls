public with sharing class M_ResultsHated {
    public static String endpoint = 'https://api.themoviedb.org/3';
    public static String apiKey = '2a226b222f0619bd09647e3c738cf7ee';

    @AuraEnabled
    public static M_ResponseMovie getHatedMovies() {
        List<MovieExtras__c> hatedMovies = [SELECT Id, IdMovie__c FROM MovieExtras__c WHERE IsHate__c = true ORDER BY Name];

        M_ResponseMovie tempResponseMovie = new M_ResponseMovie();
        tempResponseMovie.page = 1;
        tempResponseMovie.total_results = hatedMovies.size();

        Decimal tempTotalPages = tempResponseMovie.total_results / 20.0;
        tempResponseMovie.total_pages = Integer.valueOf(tempTotalPages.round(System.RoundingMode.CEILING));

        List<M_ResponseMovie.Results> tempResults = new List<M_ResponseMovie.Results>();

        for (MovieExtras__c movieExtras : hatedMovies) {
            M_ResponseMovieDetail movieFromDb = getHatedMoviesFromDb(movieExtras.IdMovie__c);

            if (movieFromDb.id != null) {
                M_ResponseMovie.Results resultsFromDb = convertM_ResponseMovieDetail2M_ResponseMovie_Results(movieFromDb);
                tempResults.add(resultsFromDb);
            } else {
                Decimal tempIdMovie = Decimal.valueOf(movieExtras.IdMovie__c);

                List<Movie_Inner_Db__c> moviesFromInnerDb = [
                        SELECT Id, Adult__c, Backdrop_Path__c, Is_Favorite__c, Is_Hated__c, Original_Language__c, Original_Title__c, Overview__c,
                                Popularity__c, Poster_Path__c, Release_Date__c, Title__c, Video__c, Vote_Average__c, Vote_Count__c, IdGenerated__c
                        FROM Movie_Inner_Db__c
                        WHERE IdGenerated__c = :tempIdMovie AND isActive__c = true
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

                    tempResults.add(tempMovie);
                }
            }
        }

        tempResponseMovie.results = tempResults;

        tempResponseMovie.results.sort();

        return tempResponseMovie;
    }

    private static M_ResponseMovieDetail getHatedMoviesFromDb(String idMovie) {
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        Http http = new Http();
        HttpResponse res;

        req.setEndpoint(endpoint + '/movie/' + idMovie + '?api_key=' + apiKey);
        try {
            res = http.send(req);

            M_ResponseMovieDetail responseMovieDetail = (M_ResponseMovieDetail) JSON.deserialize(res.getBody(), M_ResponseMovieDetail.class);

            return responseMovieDetail;
        } catch (system.CalloutException e) {
            System.debug('error >>> ' + e);
        }

        return null;
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

    private static M_ResponseMovie.Results convertM_ResponseMovieDetail2M_ResponseMovie_Results(M_ResponseMovieDetail responseMovieDetail) {
        M_ResponseMovie.Results tempResult = new M_ResponseMovie.Results();
        tempResult.vote_count = responseMovieDetail.vote_count;
        tempResult.id = responseMovieDetail.id;
        tempResult.video = responseMovieDetail.video;
        tempResult.vote_average = responseMovieDetail.vote_average;
        tempResult.title = responseMovieDetail.title;
        tempResult.popularity = responseMovieDetail.popularity;
        tempResult.poster_path = responseMovieDetail.poster_path;
        tempResult.original_language = responseMovieDetail.original_language;
        tempResult.original_title = responseMovieDetail.original_title;
        //tempResult.genre_ids = responseMovieDetail.genres;
        tempResult.backdrop_path = responseMovieDetail.backdrop_path;
        tempResult.adult = responseMovieDetail.adult;
        tempResult.overview = responseMovieDetail.overview;
        tempResult.release_date = responseMovieDetail.release_date;

        return tempResult;
    }

}