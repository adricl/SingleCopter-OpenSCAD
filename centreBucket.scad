// Motor mount for centre of bucket dual copter.
use <library/Utils.scad>
$fn=50;

rodSize = 12 + 1; //1 more than the actual for 3d printer tolerances 
rodLength = 255;
rodSeperatorWidth = 2;
rodGroupHeight = rodSize * 2 + rodSeperatorWidth;

motorMountWidthFromHole = 1;
motorMountHoleSize = 3 + 1; //1 more than the actual for 3d printer tolerances 
motorMountThickness = 2.5;
motorMountWidth = 7 + 1; //1 more than the actual for 3d printer tolerances 
motorMidHoleToHoleWidth = 36;
motorMountMinThickness = 31;

screwLength = 25;
nutWidth = 5 + 1; //1 more than the actual for 3d printer tolerances 
nutHeight= 2.5;

motorDepth = 30;
motorWidthInner = motorMidHoleToHoleWidth - motorMountHoleSize + motorMountWidthFromHole; // Mid mount hole to mid mount hole + rest of hole + 

mountInnerWidth = motorMountMinThickness;
mountWidth = motorMountWidthFromHole * 2 + motorMidHoleToHoleWidth + motorMountHoleSize; 

mountThickness = mountWidth - mountInnerWidth;
echo("Mount Width = ", mountThickness/2, " Inner Width=", mountInnerWidth, " OuterWidth ", mountWidth);
mountHeight = motorDepth + rodGroupHeight + motorMountThickness + 4;

//rods();

//motorMount();

difference() {
	move(z=-4)centreMount();
	rods();
}


module centreMount() {
	difference() {
		cylinder(h= mountHeight, d=mountWidth);
		move(z=-1) cylinder(h= mountHeight + 2, d=mountInnerWidth);
		motorMount();
		wireHole();
	}
}

module motorMount(){
	copy_move(rz=180) {
		copy_mirror(y=1) {
			move(rz=45) {
			//Mount for motor
			move(x=-motorMountWidth/2, y=mountInnerWidth/2 -1, z=mountHeight-motorMountThickness) 
			cube([motorMountWidth, mountThickness/2 +2,  motorMountThickness+1]);
			
			//Srew thread section
			move(x=0, y=mountInnerWidth/2 + motorMountHoleSize/2 + 1 , z=mountHeight - motorMountThickness - screwLength ) 
			cylinder(h=screwLength + 1, d=motorMountHoleSize);
			
			//Nut holder
			move(x=-nutWidth/2, y=mountInnerWidth/2 -1, z=mountHeight - motorMountThickness - screwLength + 2) 
			cube([nutWidth, mountThickness/2 +2,  motorMountThickness]);
			}
		}
	}
}

module wireHole(){
	wireHoleWidth = 5;
	copy_move(rz=90) {
			move(x=-motorMountWidth/2, y=mountInnerWidth/2 -1, z=mountHeight-motorMountThickness) 
			cube([wireHoleWidth, mountThickness/2 +2,  motorMountThickness+1]);
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
