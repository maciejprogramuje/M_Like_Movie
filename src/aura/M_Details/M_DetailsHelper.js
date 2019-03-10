({
    tile: function(component, event) {
        component.set("v.isOpenAddCommentDialog", false);
        component.set("v.isOpenDeleteConfDialog", false);

        component.set("v.currentUserId", $A.get("$SObjectType.CurrentUser.Id"));


//        tu ustawiam movie
        let clickedMovie = event.getParam("movie");
        component.set("v.movie", clickedMovie);

        let search = component.get("c.getCast");
        search.setParam("movieId", component.get("v.movie.id"));
        search.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.movieCast", response.getReturnValue());
            }
        });
        $A.enqueueAction(search);

        let action = component.get("c.getMovieExtras");
        action.setParam("movieId", component.get("v.movie.id"));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.movieExtras", response.getReturnValue());
                component.set("v.isVoteShown", true);
            }
        });
        $A.enqueueAction(action);

        this.getAllComments(component, event);

        this.switchSpinner(component, true);
    },

    clear: function(component, event) {
        component.set("v.movie", null);
        component.set("v.movieExtras", null);
    },

    addToFavorites: function(component, event) {
        let action = component.get("c.addToFavorites");





        console.log("movieId="+component.get("v.movie.id"));





        action.setParam("movieId", component.get("v.movie.id"));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.movieExtras", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);

        this.switchSpinner(component, true);
    },

    hateThisMovie: function(component, event) {
        let action = component.get("c.hateThisMovie");
        action.setParam("movieId", component.get("v.movie.id"));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.movieExtras", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);

        this.switchSpinner(component, true);
    },

    removeFromFavoritesAndHated: function(component, event) {
        let action = component.get("c.removeFromFavoritesAndHated");
        action.setParam("movieId", component.get("v.movie.id"));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.movieExtras", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);

        this.switchSpinner(component, true);
    },

    vote: function(component, event, voteVal) {
        let action = component.get("c.setMovieExtras_Votes");
        action.setParam("movieId", component.get("v.movie.id"));
        action.setParam("myVoteValue", voteVal);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.movieExtras", response.getReturnValue());
                component.set("v.isVoteShown", false);
            }
        });
        $A.enqueueAction(action);

        this.switchSpinner(component, true);
    },

    clickComment: function(component, event) {
        component.set("v.isOpenAddCommentDialog", true);
    },

    closeComment: function(component, event) {
        component.set("v.isOpenAddCommentDialog", false);
    },

    getAllComments: function(component, event) {
        let actionComm = component.get("c.getComments");
        actionComm.setParam("movieId", component.get("v.movie.id"));
        actionComm.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.comments", response.getReturnValue());
            }
        });
        $A.enqueueAction(actionComm);
    },

    addComment: function(component, event) {
        let action = component.get("c.addComment");
        action.setParam("movieId", component.get("v.movie.id"));
        action.setParam("commentVal", component.get("v.commentVal"));
        action.setParam("commId", component.get("v.editCommentId"));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                component.set("v.isOpenAddCommentDialog", false);
                component.set("v.commentVal", null);
                component.set("v.editCommentId", null);

                this.getAllComments(component, event);
            }
        });
        $A.enqueueAction(action);

        this.switchSpinner(component, true);
    },

    editComment: function(component, event) {
        let commId = event.getSource().get("v.value");

        let action = component.get("c.editComment");
        action.setParam("commId", commId);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                this.switchSpinner(component, false);

                let respVal = response.getReturnValue();

                component.set("v.commentVal", respVal.Comment__c);
                component.set("v.editCommentId", commId);

                this.clickComment(component, event);
            }
        });
        $A.enqueueAction(action);

        this.switchSpinner(component, true);
    },

    deleteComment: function(component, event) {
        component.set("v.isOpenDeleteConfDialog", false);

        let action = component.get("c.deleteComment");
        action.setParam("commId", component.get("v.deleteCommentId"));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.editCommentId", null);
                component.set("v.commentVal", null);
                component.set("v.deleteCommentId", null);

                this.getAllComments(component, event);
            }
        });
        $A.enqueueAction(action);

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

    closeDelConfDialog: function(component, event) {
        component.set("v.isOpenDeleteConfDialog", false);
    },

    showDelConfDialog: function(component, event) {
        let commId = event.getSource().get("v.value");
        component.set("v.deleteCommentId", commId);
        component.set("v.isOpenDeleteConfDialog", true);
    },
})