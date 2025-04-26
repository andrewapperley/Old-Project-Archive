/**
* Created By Andrew Apperley
* 2012
*/
var themeArray = [];
var themeList = Ti.UI.createTableView({
	top:65,
	width:290,
	height:242,
	backgroundColor:'transparent',
    rowBackgroundColor:'transparent',
    data:themeArray,
	editable:false
});


themeList.addEventListener('click', function(data) {

    if (themes.themeArray) {

        Titanium.App.Properties.setString('activeTheme', themes.themeArray[data.index].title);
        Titanium.App.Properties.setString('font', themes.themeArray[data.index].font);
        
    };
   
   writing.themesViewBackground.animate(animations.fadeOut);
   writing.themesViewBackground.close();
    
    refresh();
    assets = null;
    assets = require('Themes/'+themeChoiceString+'/assetConstants');
    CUSTOM_FONT = Titanium.App.Properties.getString('font');
    writing.update();
    
});



exports.themeArray = themeArray;
exports.themeList = themeList;