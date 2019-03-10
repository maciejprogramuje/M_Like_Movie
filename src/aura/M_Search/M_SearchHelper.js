({
    searchMovie: function(component, event) {
        let title = component.get("v.title");

        let clearSearchEvent = $A.get("e.c:M_ClearSearchEvent");
        clearSearchEvent.fire();

        if(title) {
            let searchEvent = $A.get("e.c:M_SearchEvent");
            searchEvent.setParam("titleToSearch", title);
            searchEvent.setParam("pageToSearch", 1);
            searchEvent.fire();
        } else {
            let noSearchDataToast = $A.get("e.force:showToast");
            noSearchDataToast.setParams({
                "title": "Enter data",
                "message": "Enter movie title, please.",
                "type": "warning"
            });
            noSearchDataToast.fire();
        }
    },

    searchPerson: function(component, event) {
        let person = component.get("v.person");

        let clearSearchEvent = $A.get("e.c:M_ClearSearchEvent");
        clearSearchEvent.fire();

        if(person) {
            let searchPersonEvent = $A.get("e.c:M_SearchPersonEvent");
            searchPersonEvent.setParam("personToSearch", person);
            searchPersonEvent.setParam("pageToSearch", 1);
            searchPersonEvent.fire();
        } else {
            let noSearchDataToast = $A.get("e.force:showToast");
            noSearchDataToast.setParams({
                "title": "Enter data",
                "message": "Enter actor / actress name, please.",
                "type": "warning"
            });
            noSearchDataToast.fire();
        }
    },


    allFavorites: function(component, event) {
        let searchEvent = $A.get("e.c:M_SearchFavoritesEvent");
        searchEvent.setParam("pageToSearch", 1);
        searchEvent.fire();
    },

    top10: function(component, event) {
        let searchEvent = $A.get("e.c:M_SearchTop10Event");
        searchEvent.setParam("pageToSearch", 1);
        searchEvent.fire();
    },

    allHated: function(component, event) {
        let searchEvent = $A.get("e.c:M_SearchHatedEvent");
        searchEvent.setParam("pageToSearch", 1);
        searchEvent.fire();
    },

    allFavoritesPersons: function(component, event) {
        let searchEvent = $A.get("e.c:M_SearchFavoritesPersonsEvent");
        searchEvent.setParam("pageToSearch", 1);
        searchEvent.fire();
    },

    allHatedPersons: function(component, event) {
        console.log("allHatedPersons");

        let searchEvent = $A.get("e.c:M_SearchHatedPersonsEvent");
        searchEvent.setParam("pageToSearch", 1);
        searchEvent.fire();
    },

    clearSearchForm: function(component, event) {
        component.set("v.title", null);
        component.set("v.person", null);

        let clearSearchEvent = $A.get("e.c:M_ClearSearchEvent");
        clearSearchEvent.fire();
    },

})