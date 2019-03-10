global class M_ResponsePersonDetail {
    @AuraEnabled
    global String birthday { get; set; }
    @AuraEnabled
    global String known_for_department { get; set; }
    @AuraEnabled
    global String deathday { get; set; }
    @AuraEnabled
    global Integer id { get; set; }
    @AuraEnabled
    global String name { get; set; }
    @AuraEnabled
    global List<String> also_known_as { get; set; }
    @AuraEnabled
    global Integer gender { get; set; }
    @AuraEnabled
    global String biography { get; set; }
    @AuraEnabled
    global Double popularity { get; set; }
    @AuraEnabled
    global String place_of_birth { get; set; }
    @AuraEnabled
    global String profile_path { get; set; }
    @AuraEnabled
    global Boolean adult { get; set; }
    @AuraEnabled
    global String imdb_id { get; set; }
    @AuraEnabled
    global String homepage { get; set; }
}