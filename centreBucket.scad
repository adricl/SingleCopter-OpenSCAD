// Motor mount for centre of bucket dual copter.
use <library/Utils.scad>
$fn=50;

rodSize = 12;
rodLength = 255;
rodSeperatorWidth = 2;
rodGroupHeight = rodSize * 2 + rodSeperatorWidth;

motorMountWidthFromHole = 1;
motorMountHoleSize = 3;
motorMountThickness = 2.5;
motorMountWidth = 7; 
motorMidHoleToHoleWidth = 36;
motorMountMinThickness = 31;

screwLength = 25;
nutWidth = 5;
nutHeight= 2.5;

motorDepth = 300;
motorWidthInner = motorMidHoleToHoleWidth - motorMountHoleSize + motorMountWidthFromHole; // Mid mount hole to mid mount hole + rest of hole + 

mountInnerWidth = motorMountMinThickness;
mountWidth = motorMountWidthFromHole * 2 + motorMidHoleToHoleWidth + motorMountHoleSize; 

mountThickness = mountWidth - mountInnerWidth;
echo("Mount Width = ", mountThickness/2, " Inner Width=", mountInnerWidth, " OuterWidth ", mountWidth);
mountHeight = motorDepth + rodGroupHeight + motorMountThickness + 2;

//rods();

//motorMount();

difference() {
	move(z=-2)centreMount();
	rods();
}


module centreMount() {
	difference() {
		cylinder(h= mountHeight, d=mountWidth);
		move(z=-1) cylinder(h= mountHeight + 2, d=mountInnerWidth);
		motorMount();
	}
}

module motorMount(){
	copy_move(rz=90) {
		copy_mirror(y=1) {
			move(x=-motorMountWidth/2, y=mountInnerWidth/2 -1, z=mountHeight-motorMountThickness) 
			cube([motorMountWidth, mountThickness/2 +2,  motorMountThickness+1]);
			move(x=0, y=mountInnerWidth/2 + motorMountHoleSize/2 + 1 , z=mountHeight-motorMountThickness - screwLength + 1 ) 
			cylinder(h=screwLength + 1, d=motorMountHoleSize);
		}
	}
	
	
}

module rods(){
	angle = 360-45;
	rodWidthMed =  (rodLength*sin(angle))/2;
	
	copy_move(z=-rodSize - rodSeperatorWidth, rz=90) {
		move(x=rodWidthMed - rodSize/2, y=rodWidthMed, z=rodGroupHeight/2, rz=angle) 
			cube([rodSize, rodLength, rodSize]);
	}
}
