({
    onInit: function(component, event, helper) {
        helper.init(component, event, helper);
    },

    clickedTile: function(component, event, helper) {
        helper.tile(component, event);
    },

    handleClear: function(component, event, helper) {
        helper.clear(component, event);
    },

    clickAddToFavoritesBtn: function(component, event, helper) {
        helper.addToFavorites(component, event);
    },

    clickRemoveFromFavoritesBtn: function(component, event, helper) {
        helper.removeFromFavoritesAndHated(component, event);
    },

    clickHateThisMovieBtn: function(component, event, helper) {
        helper.hateThisMovie(component, event);
    },

    clickRemoveFromHatedMoviesBtn: function(component, event, helper) {
        helper.removeFromFavoritesAndHated(component, event);
    },

    clickVote1: function(component, event, helper) {
        helper.vote(component, event, 1);
    },

    clickVote2: function(component, event, helper) {
        helper.vote(component, event, 2);
    },

    clickVote3: function(component, event, helper) {
        helper.vote(component, event, 3);
    },

    clickVote4: function(component, event, helper) {
        helper.vote(component, event, 4);
    },

    clickVote5: function(component, event, helper) {
        helper.vote(component, event, 5);
    },

    clickAddComment: function(component, event, helper) {
        helper.clickComment(component, event);
    },

    closeAddCommentDialog: function(component, event, helper) {
        helper.closeComment(component, event);
    },

    saveAddCommentDialog: function(component, event, helper) {
        helper.addComment(component, event);
    },

    clickEditComment: function(component, event, helper) {
        helper.editComment(component, event);
    },

    clickDeleteComment: function(component, event, helper) {
        helper.showDelConfDialog(component, event);
    },

    closeDeleteConfDialog: function(component, event, helper) {
        helper.closeDelConfDialog(component, event);
    },

    acceptDeleteConfDialog: function(component, event, helper) {
        helper.deleteComment(component, event);
    },


})