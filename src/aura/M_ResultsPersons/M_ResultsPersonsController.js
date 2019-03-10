({
    handleSearchPerson: function(component, event, helper) {
        helper.search(component, event);
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

})