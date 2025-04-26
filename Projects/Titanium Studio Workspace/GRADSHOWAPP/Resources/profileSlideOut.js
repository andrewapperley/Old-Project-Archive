/*
 * start the profile view
 */

var profileView = Ti.UI.createWindow({
   backgroundImage:'/assets/bg.jpg',
   fullscreen:true,
   width:1024,
   height:768,
   right:1024,
   top:0
});

var profileSideBar = Ti.UI.createImageView({
	image:'/assets/leftbar-portfolio.png',
	width:'auto',
	height:768,
	top:0,
	left:0,
	layout:"vertical"
});

	var profileElementName = Ti.UI.createLabel({
		width:140,
		height:120,
		top:0,
		text:"Tc",
		textAlign:"center",
		font:{fontSize:80},
		left:0
	});
	
	var profileName = Ti.UI.createLabel({
		height:'auto',
		top:-10,
		width:140,
		color:'#000000',
		textAlign:'center',
		left:0
	});
	
	var profileTitle = Ti.UI.createLabel({
		height:'auto',
		top:5,
		width:140,
		color:'#000000',
		textAlign:'center',
		left:0,
		text:'fdd',
		font:{fontSize:11}
	});
	
	var profileImage = Ti.UI.createImageView({
		width:140,
		height:190,
		left:0,
		top:0
	});
	
	var profileLink = Ti.UI.createLabel({
		textAlign:"center",
		font:({fontSize:20}),
		color:"white",
		text:"Website Link",
		width:140,
		backgroundImage:"/assets/backButton.jpg",
		height:30,
		left:0,
		top:0
	});

	var profileDescription = Ti.UI.createLabel({
		width:850,
		height:170,
		text:"",
		textAlign:"left",
		focusable:false,
		font:{fontSize:12},
		top:10,
		right:10,
	});
	
	var profilePieceImage = Ti.UI.createImageView({
		width:890,
		height:(768-profileDescription.height)-20,
		right:0,
		bottom:0
	});
	
	var profileBackButton = Ti.UI.createLabel({
		textAlign:"center",
		font:({fontSize:20}),
		color:"white",
		text:"Back",
		width:140,
		backgroundImage:"/assets/backButton.jpg",
		height:30,
		bottom:0,
		left:0
	});



/*event listener for the back button*/
profileBackButton.addEventListener('click', function(e){
	profileView.animate(slideLeft);
	win.animate(slideRight);
	Ti.API.info("clicked back");
});

/*event listener for opening up a portfolio link*/
profileLink.addEventListener('click', function(e){
	Titanium.Platform.openURL('http://'+tempLink);
	Ti.API.info(tempLink);
});

/*function to retrieve accossiated profile information*/
var getProfileData = function(){
	if(tempFirst && tempLast)
	{	
		profileElementName.text = tempFirstLetter+tempLastLetter.toLowerCase();
		profileName.text = tempFirst+"\n"+tempLast;
		profileDescription.text = tempBio;
		profileImage.image = tempProfileImage;
		profilePieceImage.image = tempPortfolioImage;
		profileTitle.text = tempTitle;
	}
};



/*opens the portfolio page + adds children*/
profileView.open();

profileView.add(profileDescription);
profileView.add(profilePieceImage);

profileSideBar.add(profileElementName);
profileSideBar.add(profileName);
profileSideBar.add(profileTitle);
profileSideBar.add(profileImage);
profileSideBar.add(profileLink);

profileView.add(profileSideBar);
profileView.add(profileBackButton);

