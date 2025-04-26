//create bullet world
var bulletsView = Ti.UI.createView();
var bullets = Box2D.createWorld(bulletsView);
mainWindow.add(bulletsView);
bullets.start();

//create click event
bulletsView.addEventListener('singletap', function(){
	
	//create bullets
	var bullet = Ti.UI.createView({
	height:5,
	width:1,
	backgroundColor: 'red',
	bottom:spaceShip.ship.bottom + spaceShip.ship.height + 1,
	left:spaceShip.shipX
	});
		
	var bulletRef = bullets.addBody(bullet, {
	density: 0,
	restitution: 0.4,
	type: "dynamic"
	});
	
	bullet.left = spaceShip.shipX;
	bullets.setGravity(0, 100);
	
});
