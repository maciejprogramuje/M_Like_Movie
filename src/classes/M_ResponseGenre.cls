global class M_ResponseGenre {
    @AuraEnabled
    global Integer page { get; set; }
    @AuraEnabled
    global Integer total_results { get; set; }
    @AuraEnabled
    global Integer total_pages { get; set; }
    @AuraEnabled
    global List<Result> results { get; set; }

    global class Result
    {
        @AuraEnabled
        global Integer vote_count { get; set; }
        @AuraEnabled
        global Integer id { get; set; }
        @AuraEnabled
        global Boolean video { get; set; }
        @AuraEnabled
        global Decimal vote_average { get; set; }
        @AuraEnabled
        global String title { get; set; }
        @AuraEnabled
        global Decimal popularity { get; set; }
        @AuraEnabled
        global String poster_path { get; set; }
        @AuraEnabled
        global String original_language { get; set; }
        @AuraEnabled
        global String original_title { get; set; }
        @AuraEnabled
        global List<Integer> genre_ids { get; set; }
        @AuraEnabled
        global String backdrop_path { get; set; }
        @AuraEnabled
        global Boolean adult { get; set; }
        @AuraEnabled
        global String overview { get; set; }
        @AuraEnabled
        global String release_date { get; set; }
    }
}

