({
    handleSearch: function(component, event, helper) {
        helper.search(component, event);
    },

    handleSearchMovieFormPersonSmallTile: function(component, event, helper) {
        helper.searchFromSmallTile(component, event);
    },

    handleClear: function(component, event, helper) {
        helper.clear(component, event);
    },

    clickPreviousPage: function(component, event, helper) {
        helper.changePage(component, event, -1);
    },

    clickNextPage: function(component, event, helper) {
        helper.changePage(component, event, 1);
    },

    openAddMovieDialog: function(component, event, helper) {
        helper.openAddMovie(component, event);
    },

    closeAddMovieDialog: function(component, event, helper) {
        helper.closeAddMovie(component, event);
    },

    acceptAddMovieDialog: function(component, event, helper) {
        helper.acceptAddMovie(component, event);
    },

    handleCloseAddPoster: function(component, event, helper) {
        helper.closeAddPoster(component, event);
    },

})