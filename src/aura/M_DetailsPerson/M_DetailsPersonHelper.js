({
    tile: function(component, event) {
        let clickedPerson = event.getParam("person");
        component.set("v.person", clickedPerson);

        let search = component.get("c.getCredits");
        search.setParam("personId", component.get("v.person.id"));
        search.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.personKnownFor", response.getReturnValue());
            }
        });
        $A.enqueueAction(search);

        let action = component.get("c.getPersonExtras");
        action.setParam("personId", component.get("v.person.id"));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.personExtras", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);

        let action2 = component.get("c.getPersonDetailsMore");
        action2.setParam("personId", component.get("v.person.id"));
        action2.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.personDetailsMore", response.getReturnValue());
            }
        });
        $A.enqueueAction(action2);

        this.switchSpinner(component, true);
    },

    addToFavorites: function(component, event) {
        let action = component.get("c.addToFavorites");
        action.setParam("personId", component.get("v.person.id"));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.personExtras", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);

        this.switchSpinner(component, true);
    },

    hateThisPerson: function(component, event) {
        let action = component.get("c.hateThisPerson");
        action.setParam("personId", component.get("v.person.id"));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.personExtras", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);

        this.switchSpinner(component, true);
    },

    removeFromFavoritesAndHated: function(component, event) {
        let action = component.get("c.removeFromFavoritesAndHated");
        action.setParam("personId", component.get("v.person.id"));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.personExtras", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);

        this.switchSpinner(component, true);
    },

    clear: function(component, event) {
        component.set("v.person", null);
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