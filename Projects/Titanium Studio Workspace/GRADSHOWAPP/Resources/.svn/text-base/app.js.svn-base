/*animations for left and right slides*/

var slideRight = Titanium.UI.createAnimation();
	slideRight.Left = 0;
	slideRight.top = 0;
	slideRight.curve = Ti.UI.iOS.ANIMATION_CURVE_EASE_IN_OUT;
	slideRight.duration = 500;

var initAnimation = Titanium.UI.createAnimation();
	initAnimation.Left = 124;
	initAnimation.curve = Ti.UI.iOS.ANIMATION_CURVE_EASE_IN_OUT;
	initAnimation.duration = 1500;



var slideLeft = Titanium.UI.createAnimation();
	slideLeft.left = 1024;
	slideLeft.top = 0;
	slideLeft.curve = Ti.UI.iOS.ANIMATION_CURVE_EASE_IN_OUT;
	slideLeft.duration = 600;

/*profile variables to hold the temp values*/
var tempFirstLetter;
var tempLastLetter;
var	tempFirst;
var	tempLast;
var	tempDescription;
var	tempBio;
var	tempProfileImage;
var	tempLink;
var	tempPortfolioImage;
var	tempID;
var tempTitle;

/*
 * start build
 */

/* sets linen texture background */
var win = Ti.UI.createWindow({
   backgroundImage:'/assets/bg.jpg',
   fullscreen:true,
   left:0,
    width:1024,
   height:768,
   top:0
});
var BACKGROUND = Ti.UI.createWindow({
   backgroundImage:'/assets/bg.jpg',
   fullscreen:true,
   left:0,
    width:1024,
   height:768,
   top:0
});

/* keeps the ipad orientation to landscape. we won't be doing portrait mode */
win.orientationModes = [Ti.UI.LANDSCAPE_LEFT, Ti.UI.LANDSCAPE_RIGHT]; 

/* creates image space for left bar */
var leftBar = Ti.UI.createImageView({
	image:'/assets/leftbar.png',
	width:'auto',
	height:768,
	top:0,
	left:0
});

/* adds row 1 of portfolio scrollviews */
var scrollRow1 = Ti.UI.createScrollView({
	top:0,
	left:110,
	height:192,
    width:900,
    contentHeight:192,
    contentWidth:'auto'
});

/* adds row 2 of portfolio scrollviews */
var scrollRow2 = Ti.UI.createScrollView({
	top:192,
	left:100,
	height:192,
	width:900,
	contentHeight:192,
	contentWidth:'auto'
})

/* adds row 3 of portfolio scrollviews */
var scrollRow3 = Ti.UI.createScrollView({
	top:384,
	left:150,
	height:192,
	width:900,
	contentHeight:192,
	contentWidth:'auto'
})

/* adds row 4 of portfolio scrollviews */
var scrollRow4 = Ti.UI.createScrollView({
	top:576,
	left:0,
	height:192,
	width:900,
	contentHeight:192,
	contentWidth:'auto'
})

/* adds scrollviews */
win.add(scrollRow1);
win.add(scrollRow2);
win.add(scrollRow3);
win.add(scrollRow4);



BACKGROUND.open();
/*starts the db call and gets arrays of everything*/
studentsReq = Titanium.Network.createHTTPClient(); 
studentsReq.open('GET', "http://www.humberinteractive.com/2012/databaseConnection.php");
studentsReq.send();

/*import the files that handle the student information and profile view*/
Ti.include('portfolio_feed.js');
Ti.include('profileSlideOut.js');

/* adds the leftbar to main window and opens it*/
win.add(leftBar);

win.open();

