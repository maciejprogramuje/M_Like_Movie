({
    search: function(component, event) {
        let person = event.getParam("personToSearch");
        let page = event.getParam("pageToSearch");

        this.innerSearch(component, person, page);
    },

    clear: function(component, event) {
        component.set("v.responsePerson", null);
    },

    changePage: function(component, event, factor) {
        let page = component.get("v.page");
        page = page + factor;
        component.set("v.page", page);

        let person = component.get("v.person");

        this.innerSearch(component, person, page);
    },

    innerSearch: function(component, person, page) {
        component.set("v.person", person);
        component.set("v.page", page);

        let search = component.get("c.getPersons");
        search.setParam("person", person);
        search.setParam("pageNo", page);
        search.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.responsePerson", response.getReturnValue());
            }
        });
        $A.enqueueAction(search);

        this.switchSpinner(component, true);
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