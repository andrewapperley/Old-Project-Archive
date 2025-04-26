/**
* Created By Andrew Apperley
* 2012
*/

var twitter_Button	= Ti.UI.createButton({
	backgroundImage:assets.assetsArray[0].TwitterButtonBG,
	top: assets.assetsArray[0].TwitterButtonBG_top,
	left: assets.assetsArray[0].TwitterButtonBG_left,
	height: assets.assetsArray[0].TwitterButtonBG_height,
	width:assets.assetsArray[0].TwitterButtonBG_width
});

twitter_Button.addEventListener('click',function(e){
	
	if(writing.PoemTextArea.value.length >= 128)
	{
		//put pop up here to tell them that it will be shortened
		 Ti.UI.createAlertDialog({title:'Poem Too Long Error',message:'Your poem would be cut off, please shorten it to post to Twitter'}).show();
	}
	else{
	   twitterbook.post({
        type : 'twitter', //(required)
        message : writing.PoemTextArea.value+' @_PoetrySlam', //(optional) 
        urls : ['http://www.silverspoon-media.ca'],// (optional) Note: This is ALWAYS an ARRAY
        success : function() {
              Ti.UI.createAlertDialog({title:'Poem Posted Successfully',message:'Your Poem has been posted successfully'}).show();
        }
    });	
	
	
	}
});

exports.twitter_Button = twitter_Button;