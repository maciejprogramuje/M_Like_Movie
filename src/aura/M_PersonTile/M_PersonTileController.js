({
    clickTile: function(component, event, helper) {
        let selected = component.get("v.person");

        let selectedMovieTileEvent = $A.get("e.c:M_SelectedPersonTileEvent");
        selectedMovieTileEvent.setParam("person", selected)

        selectedMovieTileEvent.fire();
    }
})