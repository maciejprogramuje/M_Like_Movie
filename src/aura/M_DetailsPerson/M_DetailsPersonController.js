({
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

    clickHateThisPersonBtn: function(component, event, helper) {
        helper.hateThisPerson(component, event);
    },

    clickRemoveFromHatedPersonBtn: function(component, event, helper) {
        helper.removeFromFavoritesAndHated(component, event);
    },

})