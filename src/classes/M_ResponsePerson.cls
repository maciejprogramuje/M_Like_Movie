global class M_ResponsePerson {
    @AuraEnabled
    public Integer page { get; set; }
    @AuraEnabled
    public Integer total_results { get; set; }
    @AuraEnabled
    public Integer total_pages { get; set; }
    @AuraEnabled
    public List<Result> results { get; set; }

    public class KnownFor {
        @AuraEnabled
        public Decimal vote_average { get; set; }
        @AuraEnabled
        public Integer vote_count { get; set; }
        @AuraEnabled
        public Integer id { get; set; }
        @AuraEnabled
        public Boolean video { get; set; }
        @AuraEnabled
        public String media_type { get; set; }
        @AuraEnabled
        public String title { get; set; }
        @AuraEnabled
        public Decimal popularity { get; set; }
        @AuraEnabled
        public String poster_path { get; set; }
        @AuraEnabled
        public String original_language { get; set; }
        @AuraEnabled
        public String original_title { get; set; }
        @AuraEnabled
        public List<Integer> genre_ids { get; set; }
        @AuraEnabled
        public String backdrop_path { get; set; }
        @AuraEnabled
        public Boolean adult { get; set; }
        @AuraEnabled
        public String overview { get; set; }
        @AuraEnabled
        public String release_date { get; set; }
    }

    public class Result {
        @AuraEnabled
        public Decimal popularity { get; set; }
        @AuraEnabled
        public Integer id { get; set; }
        @AuraEnabled
        public String profile_path { get; set; }
        @AuraEnabled
        public String name { get; set; }
        @AuraEnabled
        public List<KnownFor> known_for { get; set; }
        @AuraEnabled
        public Boolean adult { get; set; }

        @AuraEnabled
        public Boolean is_hated { get; set; }
        @AuraEnabled
        public Boolean is_favorite { get; set; }
    }
}