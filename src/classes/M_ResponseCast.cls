global class M_ResponseCast {
    @AuraEnabled
    public Integer id { get; set; }
    @AuraEnabled
    public List<OneCast> casts { get; set; }
    @AuraEnabled
    public List<Crew> crew { get; set; }

    public class OneCast {
        @AuraEnabled
        public Integer cast_id { get; set; }
        @AuraEnabled
        public String character { get; set; }
        @AuraEnabled
        public String credit_id { get; set; }
        @AuraEnabled
        public Integer gender { get; set; }
        @AuraEnabled
        public Integer id { get; set; }
        @AuraEnabled
        public String name { get; set; }
        @AuraEnabled
        public Integer order { get; set; }
        @AuraEnabled
        public String profile_path { get; set; }
    }

    public class Crew {
        @AuraEnabled
        public String credit_id { get; set; }
        @AuraEnabled
        public String department { get; set; }
        @AuraEnabled
        public Integer gender { get; set; }
        @AuraEnabled
        public Integer id { get; set; }
        @AuraEnabled
        public String job { get; set; }
        @AuraEnabled
        public String name { get; set; }
        @AuraEnabled
        public String profile_path { get; set; }
    }
}