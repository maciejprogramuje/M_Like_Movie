public with sharing class M_Cast {
    public static String endpoint = 'http://api.themoviedb.org/3';
    public static String apiKey = '2a226b222f0619bd09647e3c738cf7ee';

    @AuraEnabled
    public static MovieExtras__c getMovieExtras(String movieId) {
        List<MovieExtras__c> moviesExtras = [SELECT Id, IdMovie__c, IsFavorite__c, IsHate__c, All_Votes__c FROM MovieExtras__c WHERE IdMovie__c = :movieId];

        if (moviesExtras.isEmpty()) {
            return null;
        } else {
            return moviesExtras.get(0);
        }
    }

    @AuraEnabled
    public static List<Movie_Comment__c> getComments(String movieId) {
        List<Movie_Comment__c> comments = [SELECT Id, IdMovie__c, Comment__c, LastModifiedDate, LastModifiedById, User_Name__c FROM Movie_Comment__c WHERE IdMovie__c = :movieId ORDER BY LastModifiedDate DESC];

        if (comments.isEmpty()) {
            return null;
        } else {
            return comments;
        }
    }

    @AuraEnabled
    public static M_ResponseCast getCast(String movieId) {
        return getCastMovieFromDb(movieId);
    }

    private static M_ResponseCast getCastMovieFromDb(String movieId) {
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setEndpoint(endpoint + '/movie/' + movieId + '/casts?api_key=' + apiKey);

        Http http = new Http();
        HttpResponse res;

        try {
            res = http.send(req);

            M_ResponseCast responseCast = (M_ResponseCast) JSON.deserialize(res.getBody().replaceAll('"cast":', '"casts":'), M_ResponseCast.class);

            return responseCast;
        } catch (system.CalloutException e) {
            System.debug('error >>> ' + e);
        }

        return null;
    }

    @AuraEnabled
    public static MovieExtras__c addToFavorites(String movieId) {
        List<MovieExtras__c> moviesExtras = [SELECT Id, IdMovie__c, IsFavorite__c, IsHate__c, All_Votes__c FROM MovieExtras__c WHERE IdMovie__c = :movieId AND CreatedById = :UserInfo.getUserId()];

        if (moviesExtras.isEmpty()) {
            MovieExtras__c movieExtras = new MovieExtras__c();
            movieExtras.IdMovie__c = movieId;
            movieExtras.IsFavorite__c = true;
            movieExtras.IsHate__c = false;
            insert movieExtras;

            return movieExtras;
        } else {
            moviesExtras.get(0).IsFavorite__c = true;
            moviesExtras.get(0).IsHate__c = false;
            update moviesExtras.get(0);

            return moviesExtras.get(0);
        }
    }

    @AuraEnabled
    public static MovieExtras__c hateThisMovie(String movieId) {
        List<MovieExtras__c> moviesExtras = [SELECT Id, IdMovie__c, IsFavorite__c, IsHate__c, All_Votes__c FROM MovieExtras__c WHERE IdMovie__c = :movieId AND CreatedById = :UserInfo.getUserId()];

        if (moviesExtras.isEmpty()) {
            MovieExtras__c movieExtras = new MovieExtras__c();
            movieExtras.IdMovie__c = movieId;
            movieExtras.IsFavorite__c = false;
            movieExtras.IsHate__c = true;
            insert movieExtras;

            return movieExtras;
        } else {
            moviesExtras.get(0).IsFavorite__c = false;
            moviesExtras.get(0).IsHate__c = true;
            update moviesExtras.get(0);

            return moviesExtras.get(0);
        }
    }

    @AuraEnabled
    public static MovieExtras__c removeFromFavoritesAndHated(String movieId) {
        List<MovieExtras__c> moviesExtras = [SELECT Id, IdMovie__c, IsFavorite__c, IsHate__c, All_Votes__c FROM MovieExtras__c WHERE IdMovie__c = :movieId AND CreatedById = :UserInfo.getUserId()];

        if (moviesExtras.isEmpty()) {
            MovieExtras__c movieExtras = new MovieExtras__c();
            movieExtras.IdMovie__c = movieId;
            movieExtras.IsFavorite__c = false;
            movieExtras.IsHate__c = false;
            insert movieExtras;

            return movieExtras;
        } else {
            moviesExtras.get(0).IsFavorite__c = false;
            moviesExtras.get(0).IsHate__c = false;
            update moviesExtras.get(0);

            return moviesExtras.get(0);
        }
    }

    @AuraEnabled
    public static MovieExtras__c setMovieExtras_Votes(String movieId, Integer myVoteValue) {
        List<MovieExtras__c> moviesExtras = [SELECT Id, IdMovie__c, IsFavorite__c, IsHate__c, All_Votes__c FROM MovieExtras__c WHERE IdMovie__c = :movieId];

        if (moviesExtras.isEmpty()) {
            MovieExtras__c movieExtras = new MovieExtras__c();
            movieExtras.IdMovie__c = movieId;
            movieExtras.My_Vote__c = myVoteValue;

            if (movieExtras.All_Votes__c != null) {
                movieExtras.All_Votes__c = ((movieExtras.All_Votes__c + myVoteValue) / 2.0).setScale(2, RoundingMode.HALF_UP);
            } else {
                movieExtras.All_Votes__c = myVoteValue;
            }

            insert movieExtras;

            return movieExtras;
        } else {
            moviesExtras.get(0).My_Vote__c = myVoteValue;

            if (moviesExtras.get(0).All_Votes__c != null) {
                moviesExtras.get(0).All_Votes__c = ((moviesExtras.get(0).All_Votes__c + myVoteValue) / 2.0).setScale(2, RoundingMode.HALF_UP);
            } else {
                moviesExtras.get(0).All_Votes__c = myVoteValue;
            }

            update moviesExtras.get(0);

            return moviesExtras.get(0);
        }
    }

    @AuraEnabled
    public static void addComment(String movieId, String commentVal, String commId) {
        if (commId == null) {
            Movie_Comment__c movieComment = new Movie_Comment__c();
            movieComment.IdMovie__c = movieId;
            movieComment.Comment__c = commentVal;
            movieComment.User_Name__c = UserInfo.getFirstName() + ' ' + UserInfo.getLastName();

            insert movieComment;
        } else {
            List<Movie_Comment__c> comments = [SELECT Id, Comment__c FROM Movie_Comment__c WHERE Id = :commId];
            comments.get(0).Comment__c = commentVal;

            update comments.get(0);
        }
    }

    @AuraEnabled
    public static Movie_Comment__c editComment(String commId) {
        List<Movie_Comment__c> comments = [SELECT Id, IdMovie__c, Comment__c, LastModifiedDate, LastModifiedById, User_Name__c FROM Movie_Comment__c WHERE Id = :commId];

        if (comments.isEmpty()) {
            return null;
        } else {
            return comments.get(0);
        }
    }

    @AuraEnabled
    public static void deleteComment(String commId) {
        List<Movie_Comment__c> comments = [SELECT Id FROM Movie_Comment__c WHERE Id = :commId];

        delete comments.get(0);
    }

}