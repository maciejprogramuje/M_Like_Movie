({
    search: function(component, event) {
        let page = event.getParam("pageToSearch");

        let searchFav = component.get("c.getFavMovies");
        searchFav.setParam("pageNo", page);
        searchFav.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.responseMovie", response.getReturnValue());
                component.set("v.page", 1);
            }
        });
        $A.enqueueAction(searchFav);

        this.switchSpinner(component, true);
    },

    clear: function(component, event) {
        component.set("v.responseMovie", null);
    },

    changePage: function(component, event, factor) {
        let page = component.get("v.page");
        page = page + factor;
        component.set("v.page", page);
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