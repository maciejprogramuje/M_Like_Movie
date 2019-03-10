({
    doSave: function(component, event, helper) {
        let fileId = component.find("fileId");
        if (fileId) {
            let files = fileId.get("v.files");

            if (files && files.length > 0) {
                helper.uploadHelper(component, event);
            } else {
                let toast = $A.get("e.force:showToast");
                toast.setParams({
                    "title": "Not Valid File Format",
                    "message": "Please Select a Valid File",
                    "type": "warning"
                });
                toast.fire();

//                alert('Please Select a Valid File');
            }
        }
    },

    handleFilesChange: function(component, event, helper) {
        let fileName = 'No File Selected..';

        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName", fileName);
    },

    closeDialog: function(component, event) {
        let closeAddPosterEvent = $A.get("e.c:M_CloseAddPosterEvent");
        closeAddPosterEvent.fire();
    },
})