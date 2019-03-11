({
    search: function(component, event) {
        component.set("v.isShowAddMovieDialog", false);
        component.set("v.isShowAddPosterDialog", false);

        let page = event.getParam("pageToSearch");
        let genre = event.getParam("genreToSearch");



        this.innerSearch(component, genre, page);
    },

    clear: function(component, event) {
        component.set("v.responseMovie", null);
    },

    changePage: function(component, event, factor) {
        let page = component.get("v.page");
        page = page + factor;
        component.set("v.page", page);

        let genre = component.get("v.genre");

        this.innerSearch(component, genre, page);
    },

    innerSearch: function(component, genre, page) {
        component.set("v.page", page);
        component.set("v.genre", genre);

        let search = component.get("c.getMovies");
        search.setParam("pageNo", page);
        search.setParam("genre", genre);
        search.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.responseMovie", response.getReturnValue());

                let size = component.get("v.responseMovie.results").length;

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
        component.set("v.addGenre", "none");

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
            search.setParam("addGenre", component.get("v.addGenre"));


            search.setCallback(this, function(response) {
                var state = response.getState();
                if(state === "SUCCESS") {
                    this.switchSpinner(component, false);

                    component.set("v.parentId", response.getReturnValue());

                    component.set("v.addTitle", null);
                    component.set("v.addOriginalTitle", null);
                    component.set("v.addReleaseDate", null);
                    component.set("v.addOverview", null);
                    component.set("v.addGenre", "none");

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
        component.set("v.addGenre", "none");

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