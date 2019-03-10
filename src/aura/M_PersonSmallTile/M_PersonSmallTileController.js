({
    clickTile: function(component, event, helper) {
        let selected = component.get("v.personSmall");

        let selectedMovieTileEvent = $A.get("e.c:M_SelectedPersonSmallTileEvent");
        selectedMovieTileEvent.setParam("person", selected)

        selectedMovieTileEvent.fire();
    },

    onInit: function(component, event, handler) {
        let name = component.get("v.personSmall.name");
        if(name.length > 20) {
            name = name.substring(0, 20);
            name = name + "...";
        }

        component.set("v.personSmall.name", name);
    }
})