public with sharing class M_ResultsPersons {
    public static String endpoint = 'https://api.themoviedb.org/3/search';
    public static String apiKey = '2a226b222f0619bd09647e3c738cf7ee';

    @AuraEnabled
    public static M_ResponsePerson getPersons(String person, Integer pageNo) {
        return getPersonsFromDb(person, pageNo);
    }

    private static M_ResponsePerson getPersonsFromDb(String person, Integer pageNo) {
        person = person.replaceAll(' ', '%20');

        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        Http http = new Http();
        HttpResponse res;

        req.setEndpoint(endpoint + '/person?api_key=' + apiKey + '&language=en-US&query=' + person + '&page=' + pageNo + '&include_adult=false');
        try {
            res = http.send(req);

            M_ResponsePerson responsePerson = (M_ResponsePerson) JSON.deserialize(res.getBody(), M_ResponsePerson.class);

            assignHated(responsePerson);
            assignFavorite(responsePerson);

            return responsePerson;
        } catch (system.CalloutException e) {
            System.debug('error >>> ' + e);
        }

        return null;
    }

    private static void assignHated(M_ResponsePerson respPerson) {
        List<Person_Extras__c> hatedPersons = [SELECT Id, IdPerson__c FROM Person_Extras__c WHERE IsHate__c = TRUE];

        for(Person_Extras__c hatedPerson : hatedPersons) {
            for(M_ResponsePerson.Result result : respPerson.results) {
                if (String.valueOf(result.id).equals(hatedPerson.IdPerson__c))  {
                    result.is_hated = true;
                    break;
                }
            }
        }
    }

    private static void assignFavorite(M_ResponsePerson respPerson) {
        List<Person_Extras__c> hatedPersons = [SELECT Id, IdPerson__c FROM Person_Extras__c WHERE IsFavorite__c = TRUE];

        for(Person_Extras__c hatedPerson : hatedPersons) {
            for(M_ResponsePerson.Result result : respPerson.results) {
                if (String.valueOf(result.id).equals(hatedPerson.IdPerson__c))  {
                    result.is_favorite = true;
                    break;
                }
            }
        }
    }


}