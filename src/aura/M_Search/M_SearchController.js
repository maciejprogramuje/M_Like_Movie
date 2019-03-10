({
    clickSearch: function(component, event, helper) {
        helper.searchMovie(component, event);
    },

    clickSearchPerson: function(component, event, helper) {
        helper.searchPerson(component, event);
    },

    clickClear: function(component, event, helper) {
        helper.clearSearchForm(component, event);
    },

    clickAllFavorites: function(component, event, helper) {
        helper.allFavorites(component, event);
    },

    clickTop10: function(component, event, helper) {
        helper.top10(component, event);
    },

    clickAllHated: function(component, event, helper) {
        helper.allHated(component, event);
    },

    clickAllFavoritesPersons: function(component, event, helper) {
        helper.allFavoritesPersons(component, event);
    },

    clickAllHatedPersons: function(component, event, helper) {
        helper.allHatedPersons(component, event);
    },
})