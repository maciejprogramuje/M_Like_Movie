global class M_ResponseCredits {
    @AuraEnabled
    public List<OneCast> casts { get; set; }
    @AuraEnabled
    public List<Crew> crew { get; set; }
    @AuraEnabled
    public Integer id { get; set; }

    public class OneCast {
        @AuraEnabled
        public String character { get; set; }
        @AuraEnabled
        public String credit_id { get; set; }
        @AuraEnabled
        public String release_date { get; set; }
        @AuraEnabled
        public Integer vote_count { get; set; }
        @AuraEnabled
        public Boolean video { get; set; }
        @AuraEnabled
        public Boolean adult { get; set; }
        @AuraEnabled
        public Decimal vote_average { get; set; }
        @AuraEnabled
        public String title { get; set; }
        @AuraEnabled
        public List<String> genre_ids { get; set; }
        @AuraEnabled
        public String original_language { get; set; }
        @AuraEnabled
        public String original_title { get; set; }
        @AuraEnabled
        public Decimal popularity { get; set; }
        @AuraEnabled
        public Integer id { get; set; }
        @AuraEnabled
        public String backdrop_path { get; set; }
        @AuraEnabled
        public String overview { get; set; }
        @AuraEnabled
        public String poster_path { get; set; }
    }

    public class Crew {
        @AuraEnabled
        public Integer id { get; set; }
        @AuraEnabled
        public String department { get; set; }
        @AuraEnabled
        public String original_language { get; set; }
        @AuraEnabled
        public String original_title { get; set; }
        @AuraEnabled
        public String job { get; set; }
        @AuraEnabled
        public String overview { get; set; }
        @AuraEnabled
        public Integer vote_count { get; set; }
        @AuraEnabled
        public Boolean video { get; set; }
        @AuraEnabled
        public String poster_path { get; set; }
        @AuraEnabled
        public String backdrop_path { get; set; }
        @AuraEnabled
        public String title { get; set; }
        @AuraEnabled
        public Decimal popularity { get; set; }
        @AuraEnabled
        public List<String> genre_ids { get; set; }
        @AuraEnabled
        public Decimal vote_average { get; set; }
        @AuraEnabled
        public Boolean adult { get; set; }
        @AuraEnabled
        public String release_date { get; set; }
        @AuraEnabled
        public String credit_id { get; set; }
    }
}