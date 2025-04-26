/**
* Created By Andrew Apperley
* 2012
*/
var email_Button = Ti.UI.createButton({
	backgroundImage:assets.assetsArray[0].EmailButton,
	width: assets.assetsArray[0].EmailButton_width,
	height: assets.assetsArray[0].EmailButton_height,
	top: assets.assetsArray[0].EmailButton_top,
	left: assets.assetsArray[0].EmailButton_left
});
var emailDialog = Titanium.UI.createEmailDialog({html:true});

email_Button.addEventListener('click', function(e){
emailDialog.subject = "Hey check out this great poem I made";
emailDialog.messageBody = '"' + writing.PoemTextArea.value + ' "' +'<br /><br />' + "<center><b>\n\n- created with Poetry Slam</b></center>";
emailDialog.open();

});

emailDialog.addEventListener('complete', function(e) {
        if(e.result == emailDialog.SENT) {
            alert("Your email has been sent");
 
        } else {
            alert("There was an error sending your email, please try again later.");
        }
    });
    
exports.email_Button = email_Button;