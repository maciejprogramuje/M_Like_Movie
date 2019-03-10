public with sharing class M_DetailsPerson {
    public static String endpoint = 'http://api.themoviedb.org/3';
    public static String apiKey = '2a226b222f0619bd09647e3c738cf7ee';

    @AuraEnabled
    public static Person_Extras__c getPersonExtras(String personId) {
        List<Person_Extras__c> personExtras = [SELECT Id, IdPerson__c, IsFavorite__c, IsHate__c FROM Person_Extras__c WHERE IdPerson__c = :personId];

        if (personExtras.isEmpty()) {
            return null;
        } else {
            return personExtras.get(0);
        }
    }

    @AuraEnabled
    public static M_ResponsePersonDetailsMore getPersonDetailsMore(String personId) {
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setEndpoint(endpoint + '/person/' + personId + '?api_key=' + apiKey + '&language=en-US');

        Http http = new Http();
        HttpResponse res;

        try {
            res = http.send(req);

            M_ResponsePersonDetailsMore responsePersonDetailsMore = (M_ResponsePersonDetailsMore) JSON.deserialize(res.getBody(), M_ResponsePersonDetailsMore.class);

            System.debug('responsePersonDetailsMore >>> ' + responsePersonDetailsMore);

            return responsePersonDetailsMore;
        } catch (System.CalloutException e) {
            System.debug('error >>> ' + e);
        }

        return null;
    }

    @AuraEnabled
    public static M_ResponseCredits getCredits(String personId) {
        return getCreditsForFromDb(personId);
    }

    private static M_ResponseCredits getCreditsForFromDb(String personId) {
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setEndpoint(endpoint + '/person/' + personId + '/movie_credits?api_key=' + apiKey);

        Http http = new Http();
        HttpResponse res;

        try {
            res = http.send(req);

            M_ResponseCredits responseCredits = (M_ResponseCredits) JSON.deserialize(res.getBody().replaceAll('"cast":', '"casts":'), M_ResponseCredits.class);

            return responseCredits;
        } catch (System.CalloutException e) {
            System.debug('error >>> ' + e);
        }

        return null;
    }

    @AuraEnabled
    public static Person_Extras__c addToFavorites(String personId) {
        List<Person_Extras__c> personsExtras = [SELECT Id, IdPerson__c, IsFavorite__c, IsHate__c FROM Person_Extras__c WHERE IdPerson__c = :personId];

        if (personsExtras.isEmpty()) {
            Person_Extras__c personExtras = new Person_Extras__c();
            personExtras.IdPerson__c = personId;
            personExtras.IsFavorite__c = true;
            personExtras.IsHate__c = false;
            insert personExtras;

            return personExtras;
        } else {
            personsExtras.get(0).IsFavorite__c = true;
            personsExtras.get(0).IsHate__c = false;
            update personsExtras.get(0);

            return personsExtras.get(0);
        }
    }

    @AuraEnabled
    public static Person_Extras__c hateThisPerson(String personId) {
        List<Person_Extras__c> personsExtras = [SELECT Id, IdPerson__c, IsFavorite__c, IsHate__c FROM Person_Extras__c WHERE IdPerson__c = :personId];

        if (personsExtras.isEmpty()) {
            Person_Extras__c personExtras = new Person_Extras__c();
            personExtras.IdPerson__c = personId;
            personExtras.IsFavorite__c = false;
            personExtras.IsHate__c = true;
            insert personExtras;

            return personExtras;
        } else {
            personsExtras.get(0).IsFavorite__c = false;
            personsExtras.get(0).IsHate__c = true;
            update personsExtras.get(0);

            return personsExtras.get(0);
        }
    }

    @AuraEnabled
    public static Person_Extras__c removeFromFavoritesAndHated(String personId) {
        List<Person_Extras__c> personsExtras = [SELECT Id, IdPerson__c, IsFavorite__c, IsHate__c FROM Person_Extras__c WHERE IdPerson__c = :personId];

        if (personsExtras.isEmpty()) {
            Person_Extras__c personExtras = new Person_Extras__c();
            personExtras.IdPerson__c = personId;
            personExtras.IsFavorite__c = false;
            personExtras.IsHate__c = false;
            insert personExtras;

            return personExtras;
        } else {
            personsExtras.get(0).IsFavorite__c = false;
            personsExtras.get(0).IsHate__c = false;
            update personsExtras.get(0);

            return personsExtras.get(0);
        }
    }
}