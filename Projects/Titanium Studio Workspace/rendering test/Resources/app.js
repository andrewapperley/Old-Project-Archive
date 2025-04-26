
var win1 = Titanium.UI.createWindow({  
    backgroundColor:'#fff'
});


win1.open();

var view = Ti.UI.createView({
    
    
});


var sprite = Ti.UI.createImageView({
   image: 'images/sprite.png',
   width: 26,
   height: 32,
   top: '50%',
   left: '50%'
});

view.add(sprite);

win1.add(view);
