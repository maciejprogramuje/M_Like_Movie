public with sharing class M_ResultsFavoritesPersons {
    public static String endpoint = 'https://api.themoviedb.org/3';
    public static String apiKey = '2a226b222f0619bd09647e3c738cf7ee';
    public static List<Person_Extras__c> favoritesPersons;

    @AuraEnabled
    public static M_ResponsePerson getFavPersons() {
        favoritesPersons = [SELECT Id, IdPerson__c FROM Person_Extras__c WHERE IsFavorite__c = true ORDER BY Name];

        M_ResponsePerson tempResponsePerson = new M_ResponsePerson();
        tempResponsePerson.page = 1;
        tempResponsePerson.total_results = favoritesPersons.size();

        Decimal tempTotalPages = tempResponsePerson.total_results / 20.0;
        tempResponsePerson.total_pages = Integer.valueOf(tempTotalPages.round(System.RoundingMode.CEILING));

        List<M_ResponsePerson.Result> tempResults = new List<M_ResponsePerson.Result>();

        for (Person_Extras__c personExtras : favoritesPersons) {
            tempResults.add(convertM_ResponsePersonDetail2M_ResponsePerson_Results(getFavPersonsFromDb(personExtras.IdPerson__c)));
        }

        tempResponsePerson.results = tempResults;

        return tempResponsePerson;
    }

    private static M_ResponsePersonDetail getFavPersonsFromDb(String idPerson) {
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        Http http = new Http();
        HttpResponse res;

        req.setEndpoint(endpoint + '/person/' + idPerson + '?api_key=' + apiKey);
        try {
            res = http.send(req);

            M_ResponsePersonDetail responsePersonDetail = (M_ResponsePersonDetail) JSON.deserialize(res.getBody(), M_ResponsePersonDetail.class);

            return responsePersonDetail;
        } catch (system.CalloutException e) {
            System.debug('error >>> ' + e);
        }

        return null;
    }

    private static M_ResponsePerson.Result convertM_ResponsePersonDetail2M_ResponsePerson_Results(M_ResponsePersonDetail responsePersonDetail) {
        M_ResponsePerson.Result tempResult = new M_ResponsePerson.Result();
        tempResult.popularity = responsePersonDetail.popularity;
        tempResult.id = responsePersonDetail.id;
        tempResult.profile_path = responsePersonDetail.profile_path;
        tempResult.name = responsePersonDetail.name;
        //tempResult.known_for = responsePersonDetail.known_for;
        tempResult.adult = responsePersonDetail.adult;

        return tempResult;
    }

}