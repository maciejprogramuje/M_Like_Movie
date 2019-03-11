global class M_ResponseMovie {
    @AuraEnabled
    global Integer page { get; set; }
    @AuraEnabled
    global Integer total_results { get; set; }
    @AuraEnabled
    global Integer total_pages { get; set; }
    @AuraEnabled
    global List<Results> results { get; set; }

    global class Results implements Comparable {
        @AuraEnabled
        global Integer vote_count { get; set; }
        @AuraEnabled
        global Integer id { get; set; }
        @AuraEnabled
        global Boolean video { get; set; }
        @AuraEnabled
        global Double vote_average { get; set; }
        @AuraEnabled
        global String title { get; set; }
        @AuraEnabled
        global Double popularity { get; set; }
        @AuraEnabled
        global String poster_path { get; set; }
        @AuraEnabled
        global String original_language { get; set; }
        @AuraEnabled
        global String original_title { get; set; }
        @AuraEnabled
        global List<String> genre_ids { get; set; }
        @AuraEnabled
        global String backdrop_path { get; set; }
        @AuraEnabled
        global Boolean adult { get; set; }
        @AuraEnabled
        global String overview { get; set; }
        @AuraEnabled
        global String release_date { get; set; }


        @AuraEnabled
        global Boolean is_hated { get; set; }
        @AuraEnabled
        global Boolean is_favorite { get; set; }
        @AuraEnabled
        global Boolean is_from_attachment { get; set; }

        global Integer compareTo(Object compareTo) {
            M_ResponseMovie.Results result1 = (M_ResponseMovie.Results) compareTo;
            if(title == result1.title) return 0;
            if(title > result1.title) return 1;
            return -1;
        }
    }
}