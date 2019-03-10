({
    search: function(component, event) {
        component.set("v.isShowAddMovieDialog", false);
        component.set("v.isShowAddPosterDialog", false);

        let title = event.getParam("titleToSearch");
        let page = event.getParam("pageToSearch");

        this.innerSearch(component, title, page);
    },

    clear: function(component, event) {
        component.set("v.responseMovie", null);
    },

    changePage: function(component, event, factor) {
        let page = component.get("v.page");
        page = page + factor;
        component.set("v.page", page);

        let title = component.get("v.title");

        this.innerSearch(component, title, page);
    },

    innerSearch: function(component, title, page) {
        component.set("v.title", title);
        component.set("v.page", page);

        let search = component.get("c.getMovies");
        search.setParam("title", title);
        search.setParam("pageNo", page);
        search.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.responseMovie", response.getReturnValue());

                let size = component.get("v.responseMovie.results").length;

                console.log("responseMovie >> "+ size);

                if(size == null || size == 0) {
                    component.set("v.isShowAddMovieDialog", true);
                }
            }
        });
        $A.enqueueAction(search);

        this.switchSpinner(component, true);
    },

    closeAddMovie: function(component, title) {
        component.set("v.addTitle", null);
        component.set("v.addOriginalTitle", null);
        component.set("v.addReleaseDate", null);
        component.set("v.addOverview", null);

        component.set("v.isShowAddMovieDialog", false);
    },

    acceptAddMovie: function(component, title, page) {
        let titleRequired = component.find("addTitleForm");
        if(titleRequired.get("v.validity").valid) {
            let search = component.get("c.addMovie");
            search.setParam("addTitle", component.get("v.addTitle"));
            search.setParam("addOriginalTitle", component.get("v.addOriginalTitle"));
            search.setParam("addReleaseDate", component.get("v.addReleaseDate"));
            search.setParam("addOverview", component.get("v.addOverview"));
            search.setCallback(this, function(response) {
                var state = response.getState();
                if(state === "SUCCESS") {
                    this.switchSpinner(component, false);

                    component.set("v.parentId", response.getReturnValue());

                    component.set("v.addTitle", null);
                    component.set("v.addOriginalTitle", null);
                    component.set("v.addReleaseDate", null);
                    component.set("v.addOverview", null);

                    component.set("v.isShowAddMovieDialog", false);
                    component.set("v.isShowAddPosterDialog", true);
                }
            });
            $A.enqueueAction(search);

            this.switchSpinner(component, true);
        } else {
            titleRequired.showHelpMessageIfInvalid();
        }
    },

    openAddMovie: function(component, title, page) {
        component.set("v.addTitle", null);
        component.set("v.addOriginalTitle", null);
        component.set("v.addReleaseDate", null);
        component.set("v.addOverview", null);

        component.set("v.isShowAddMovieDialog", true);
    },

    closeAddPoster: function(component, title) {
        component.set("v.isShowAddPosterDialog", false);
    },

    switchSpinner: function(component, status) {
        const spinnerComponent = component.find('spinner');
        if (spinnerComponent) {
            spinnerComponent.switchSpinner(status);
        } else {
            console.error("'spinner' does not exist");
        }
    },

})