/**
* Created By Andrew Apperley
* 2012
*/
var content = Ti.UI.createWindow({

	backgroundImage : assets.assetsArray[0].DeleteAllConfirm,
	height : assets.assetsArray[0].Deleting_height,
	width : assets.assetsArray[0].Deleting_width,
	top : assets.assetsArray[0].Deleting_top,
	left : assets.assetsArray[0].Deleting_left

});

var deleteButton = Ti.UI.createButton({
	width : assets.assetsArray[0].DeletingScreenYesButton_width,
	height : assets.assetsArray[0].DeletingScreenYesButton_height,
	bottom : assets.assetsArray[0].DeletingScreenYesButton_bottom,
	left : assets.assetsArray[0].DeletingScreenYesButton_left,
	backgroundImage : assets.assetsArray[0].DeletingScreenYesButton,
	backgroundSelectedImage : assets.assetsArray[0].DeletingScreenYesPressedButton
});

var cancelButton = Ti.UI.createButton({
	width : assets.assetsArray[0].DeletingScreenNoButton_width,
	height : assets.assetsArray[0].DeletingScreenNoButton_height,
	bottom : assets.assetsArray[0].DeletingScreenNoButton_bottom,
	right : assets.assetsArray[0].DeletingScreenNoButton_right,
	backgroundImage : assets.assetsArray[0].DeletingScreenNoButton,
	backgroundSelectedImage : assets.assetsArray[0].DeletingScreenNoPressedButton
});

deleteButton.addEventListener('singletap', function() {

	if(writing.loading.poemarray != [])
	{
	dbModel.deletingF();
	dbModel.loadingF();
	content.close();
	
	}
	else{
		content.close();
		
	}
});

cancelButton.addEventListener('singletap', function() {

	content.close();
	content.children = null;
	
});

exports.addChildren = function() {

	content.add(deleteButton);
	content.add(cancelButton);

}
change = function(){
    //content
    content.updateLayout({
        backgroundImage : assets.assetsArray[0].DeleteAllConfirm,
        height : assets.assetsArray[0].Deleting_height,
        width : assets.assetsArray[0].Deleting_width,
        top : assets.assetsArray[0].Deleting_top,
        left : assets.assetsArray[0].Deleting_left 
    });
    //delete button
    deleteButton.updateLayout({
        width : assets.assetsArray[0].DeletingScreenYesButton_width,
        height : assets.assetsArray[0].DeletingScreenYesButton_height,
        bottom : assets.assetsArray[0].DeletingScreenYesButton_bottom,
        left : assets.assetsArray[0].DeletingScreenYesButton_left,
        backgroundImage : assets.assetsArray[0].DeletingScreenYesButton,
        backgroundSelectedImage : assets.assetsArray[0].DeletingScreenYesPressedButton
    });
    //cancel button
    cancelButton.updateLayout({
        width : assets.assetsArray[0].DeletingScreenNoButton_width,
        height : assets.assetsArray[0].DeletingScreenNoButton_height,
        bottom : assets.assetsArray[0].DeletingScreenNoButton_bottom,
        right : assets.assetsArray[0].DeletingScreenNoButton_right,
        backgroundImage : assets.assetsArray[0].DeletingScreenNoButton,
        backgroundSelectedImage : assets.assetsArray[0].DeletingScreenNoPressedButton
    });
}
exports.change = change;
exports.content = content;
