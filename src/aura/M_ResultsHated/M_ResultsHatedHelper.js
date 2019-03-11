({
    search: function(component, event) {
        let page = event.getParam("pageToSearch");

        let searchHated = component.get("c.getHatedMovies");
        searchHated.setParam("pageNo", page);
        searchHated.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.responseMovie", response.getReturnValue());
                component.set("v.page", 1);

                let responseResults = component.get("v.responseMovie.results");
                if(responseResults.length <= 0) {
                    let noSearchDataToast = $A.get("e.force:showToast");
                    noSearchDataToast.setParams({
                        "title": "No results",
                        "message": "No any movie found",
                        "type": "warning"
                    });
                    noSearchDataToast.fire();
                }
            }
        });
        $A.enqueueAction(searchHated);

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