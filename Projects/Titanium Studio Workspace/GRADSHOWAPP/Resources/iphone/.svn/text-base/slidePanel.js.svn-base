var slidePanel = Ti.UI.createWindow
({
	height : '100%',
	width : 124,
	top : 0,
	left : -118,
	backgroundColor : 'red'
});

slidePanel.addEventListener('swipe', function(e)
{	
	if(e.direction == 'right')
	{
		slidePanel.animate(Titanium.UI.createAnimation({
			duration: 250,
	   		left: 0
			    
		}));
	}
	else if(e.direction == 'left')
	{
		slidePanel.animate(Titanium.UI.createAnimation({
	   			duration: 250,
	   			left: -118
		}));
	}
});


