/**
* Created By Andrew Apperley
* 2012
*/
var arrayOfScreens = [assets.assetsArray[0].InfoScreenBG1,assets.assetsArray[0].InfoScreenBG2,assets.assetsArray[0].InfoScreenBG3,assets.assetsArray[0].InfoScreenBG4,assets.assetsArray[0].InfoScreenBG5,assets.assetsArray[0].InfoScreenBG6];
var pageNumber = 0;

var screen = Titanium.UI.createWindow({
            height:480 - tabbedBar.buttonArray[0].width - 2,
            width:320,
            top:0,
            backgroundImage:assets.assetsArray[0].Black1pixel,
            touchEnabled:true,
            opacity: 0,
            index:8,
            backgroundRepeat: true
});

var twitter_Button  = Ti.UI.createButton({
    backgroundImage:assets.assetsArray[0].TwitterButtonBG,
            width:90,
            height:90,
            top:230,
            right:39,
            opacity: 0
});
var facebook_Button = Titanium.UI.createButton({
        backgroundImage:assets.assetsArray[0].FacebookButton,
            width:90,
            height:90,
            top:230,
            left:39,
            opacity: 0
        });
var content = Ti.UI.createView({
	
	backgroundImage: assets.assetsArray[0].InfoScreenBG1,
	height: assets.assetsArray[0].InfoScreenBG_height,
	width: assets.assetsArray[0].InfoScreenBG_width,
	top:assets.assetsArray[0].InfoScreenBG_top
	
	
});




var backButton = Ti.UI.createButton({
	
	width:assets.assetsArray[0].InfoScreenBackButton_width,
	height:assets.assetsArray[0].InfoScreenBackButton_height,
	left:assets.assetsArray[0].InfoScreenBackButton_left,
	bottom:assets.assetsArray[0].InfoScreenBackButton_bottom,
	backgroundImage:assets.assetsArray[0].InfoScreenBackButton,
	backgroundSelectedImage:assets.assetsArray[0].InfoScreenBackButton
	
});



var nextButton = Ti.UI.createButton({
	
	width:assets.assetsArray[0].InfoScreenNextButton_width,
	height:assets.assetsArray[0].InfoScreenNextButton_height,
	right:assets.assetsArray[0].InfoScreenNextButton_right,
	bottom:assets.assetsArray[0].InfoScreenNextButton_bottom,
	backgroundImage:assets.assetsArray[0].InfoScreenNextButton,
	backgroundSelectedImage:assets.assetsArray[0].InfoScreenNextButton
	
});

//functions

twitter_Button.addEventListener('singletap', function(){
    Titanium.Platform.openURL('https://twitter.com/_PoetrySlam');
});
facebook_Button.addEventListener('singletap', function(){
    Titanium.Platform.openURL('http://www.facebook.com/PoetrySlamCommunity');
});
nextButton.addEventListener('singletap', function(){

    
	pageNumber++
	
	if(pageNumber == arrayOfScreens.length-1)
    {
            facebook_Button.opacity = 1;
            twitter_Button.opacity = 1;
            twitter_Button.enabled = true;
            facebook_Button.enabled = true;
       
    } else {
        if(twitter_Button && facebook_Button)
        {
            facebook_Button.opacity = 0;
            twitter_Button.opacity = 0;
            twitter_Button.enabled = false;
            facebook_Button.enabled = false;
        }
    }
	
	content.backgroundImage = arrayOfScreens[pageNumber];
	if(pageNumber >= arrayOfScreens.length)
	{
		
		content.backgroundImage = arrayOfScreens[0];
		pageNumber = 0;
	}
	
	

	


});

backButton.addEventListener('singletap', function(){
	
	pageNumber--

    if(pageNumber == arrayOfScreens.length-1)
    {
            facebook_Button.opacity = 1;
            twitter_Button.opacity = 1;
            twitter_Button.enabled = true;
            facebook_Button.enabled = true;
       
    } else {
        if(twitter_Button && facebook_Button)
        {
            facebook_Button.opacity = 0;
            twitter_Button.opacity = 0;
            twitter_Button.enabled = false;
            facebook_Button.enabled = false;
        }
    }
    
	content.backgroundImage = arrayOfScreens[pageNumber];
	if(pageNumber < 0)
	{
		content.backgroundImage = arrayOfScreens[arrayOfScreens.length-1];
		pageNumber = arrayOfScreens.length;
	}


});

change = function(){
    //content
    content.updateLayout({
        backgroundImage: assets.assetsArray[0].InfoScreenBG1,
        height: assets.assetsArray[0].InfoScreenBG_height,
        width: assets.assetsArray[0].InfoScreenBG_width,
        top:assets.assetsArray[0].InfoScreenBG_top
    });
    arrayOfScreens = null;
    arrayOfScreens = [assets.assetsArray[0].InfoScreenBG1,assets.assetsArray[0].InfoScreenBG2,assets.assetsArray[0].InfoScreenBG3,assets.assetsArray[0].InfoScreenBG4,assets.assetsArray[0].InfoScreenBG5,assets.assetsArray[0].InfoScreenBG6];
    backButton.updateLayout({
        width:assets.assetsArray[0].InfoScreenBackButton_width,
        height:assets.assetsArray[0].InfoScreenBackButton_height,
        left:assets.assetsArray[0].InfoScreenBackButton_left,
        bottom:assets.assetsArray[0].InfoScreenBackButton_bottom,
        backgroundImage:assets.assetsArray[0].InfoScreenBackButton,
        backgroundSelectedImage:assets.assetsArray[0].InfoScreenBackButton 
    });
     nextButton.updateLayout({
        width:assets.assetsArray[0].InfoScreenNextButton_width,
        height:assets.assetsArray[0].InfoScreenNextButton_height,
        right:assets.assetsArray[0].InfoScreenNextButton_right,
        bottom:assets.assetsArray[0].InfoScreenNextButton_bottom,
        backgroundImage:assets.assetsArray[0].InfoScreenNextButton,
        backgroundSelectedImage:assets.assetsArray[0].InfoScreenNextButton
    });
   
}
exports.change = change;
exports.addChildren = function(){

screen.add(content);
content.add(facebook_Button);
content.add(twitter_Button);
content.add(backButton);
content.add(nextButton);
content.add(close.button);

}
exports.screen = screen;