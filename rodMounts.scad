// Motor mount for centre of bucket dual copter.

use <library/Utils.scad>
$fn=50;

rodSize = 12 + 1; //1 more than the actual for 3d printer tolerances 
rodLength = 280;
rodSeperatorWidth = 2;
rodGroupHeight = rodSize * 2 + rodSeperatorWidth;


difference () {
	rodMount ();
	bucketRing();
	rod();
}


module rodMount() {
	screwPosition = 	rodSize/2 + 3;

		move(rx=90, z=12, y=rodLength/2) 
		difference() {
			cylinder (h=5, d = rodSize+12, center=false);
			move(y=screwPosition) cylinder( h=10, d=4);
			move(y=-screwPosition) cylinder( h=10, d=4);
			move(x=screwPosition) cylinder( h=10, d=4);
			move(x=-screwPosition) cylinder( h=10, d=4);
		}
}

module bucketRing() {
	height = rodSize + 20;
	difference() {
		move(z=-2)cylinder(h=height, d=rodLength + 4);
		move(z=-4) cylinder(h=height + 5, d=rodLength);
	}
}

module rod(){
	move(x=-rodSize/2, z=6) cube([rodSize, rodLength, rodSize]);
}


