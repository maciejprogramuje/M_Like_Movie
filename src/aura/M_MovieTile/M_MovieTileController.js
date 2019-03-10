({
    clickTile: function(component, event, helper) {
        let selected = component.get("v.movie");

        let selectedMovieTileEvent = $A.get("e.c:M_SelectedMovieTileEvent");
        selectedMovieTileEvent.setParam("movie", selected)

        selectedMovieTileEvent.fire();
    }
})