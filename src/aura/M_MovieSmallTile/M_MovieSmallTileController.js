({
    clickTile: function(component, event, helper) {
        let selected = component.get("v.movieSmall");

        let selectedMovieTileEvent = $A.get("e.c:M_SelectedMovieSmallTileEvent");
        selectedMovieTileEvent.setParam("movie", selected)

        selectedMovieTileEvent.fire();
    },

    onInit: function(component, event, handler) {
        let title = component.get("v.movieSmall.title");
        if(title.length > 20) {
            title = title.substring(0, 20);
            title = title + "...";
        }

        component.set("v.movieSmall.title", title);
    }
})