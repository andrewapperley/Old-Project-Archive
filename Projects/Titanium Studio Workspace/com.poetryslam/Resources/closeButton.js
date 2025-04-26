/**
* Created By Andrew Apperley
* 2012
*/
var button = Ti.UI.createButton({
	
	backgroundImage: assets.assetsArray[0].CloseButton,
	width:19,
	height:20,
	right:10,
	top:10
	
});

button.addEventListener('click', function(){
	
	
	tabbedBar.tabHighlight(tabbedBar.buttonArray[2]);
	tabbedBar.removeFunction();
    	
});

change = function(){
    button.updateLayout({
        backgroundImage: assets.assetsArray[0].CloseButton
    });
}

exports.change = change;
exports.button = button;

