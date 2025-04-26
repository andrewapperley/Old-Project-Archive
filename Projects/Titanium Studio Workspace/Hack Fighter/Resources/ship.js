var ship = Ti.UI.createView({
	backgroundImage:'images/ship.png',
	width: 30,
	height: 30,
	bottom: 50
});
var shipX;
var shooting = require('shooting');
var movingShip = function(e) {
	
		shipX = e.x;
		
     //checking side to side motions
      if(e.x > 0) {
      	world.setGravity(9.91, 0);
      	
      }
      else {
      	world.setGravity(-9.91, 0);
      }
     
};

Ti.Accelerometer.addEventListener('update', movingShip);

exports.shipX = shipX;
exports.ship = ship;