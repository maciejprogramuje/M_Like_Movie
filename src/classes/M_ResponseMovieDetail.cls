global class M_ResponseMovieDetail {
    @AuraEnabled
    global Boolean adult { get; set; }
    @AuraEnabled
    global String backdrop_path { get; set; }
    @AuraEnabled
    global BelongsToCollection belongs_to_collection { get; set; }
    @AuraEnabled
    global Integer budget { get; set; }
    @AuraEnabled
    global List<Genre> genres { get; set; }
    @AuraEnabled
    global String homepage { get; set; }
    @AuraEnabled
    global Integer id { get; set; }
    @AuraEnabled
    global String imdb_id { get; set; }
    @AuraEnabled
    global String original_language { get; set; }
    @AuraEnabled
    global String original_title { get; set; }
    @AuraEnabled
    global String overview { get; set; }
    @AuraEnabled
    global double popularity { get; set; }
    @AuraEnabled
    global String poster_path { get; set; }
    @AuraEnabled
    global List<ProductionCompany> production_companies { get; set; }
    @AuraEnabled
    global List<ProductionCountry> production_countries { get; set; }
    @AuraEnabled
    global String release_date { get; set; }
    @AuraEnabled
    global Integer revenue { get; set; }
    @AuraEnabled
    global Integer runtime { get; set; }
    @AuraEnabled
    global List<SpokenLanguage> spoken_languages { get; set; }
    @AuraEnabled
    global String status { get; set; }
    @AuraEnabled
    global String tagline { get; set; }
    @AuraEnabled
    global String title { get; set; }
    @AuraEnabled
    global Boolean video { get; set; }
    @AuraEnabled
    global Double vote_average { get; set; }
    @AuraEnabled
    global Integer vote_count { get; set; }

    global class Genre {
        @AuraEnabled
        global Integer id { get; set; }
        @AuraEnabled
        global String name { get; set; }
    }

    global class ProductionCompany {
        @AuraEnabled
        global Integer id { get; set; }
        @AuraEnabled
        global String logo_path { get; set; }
        @AuraEnabled
        global String name { get; set; }
        @AuraEnabled
        global String origin_country { get; set; }
    }

    global class ProductionCountry {
        @AuraEnabled
        global String iso_3166_1 { get; set; }
        @AuraEnabled
        global String name { get; set; }
    }

    global class SpokenLanguage {
        @AuraEnabled
        global String iso_639_1 { get; set; }
        @AuraEnabled
        global String name { get; set; }
    }

    global class BelongsToCollection {
        @AuraEnabled
        global Integer id { get; set; }
        @AuraEnabled
        global String name { get; set; }
        @AuraEnabled
        global String poster_path { get; set; }
        @AuraEnabled
        global String backdrop_path { get; set; }
    }
}