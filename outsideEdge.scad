use <gridFins.scad>

propRadius = 101.6; //4 inches

outsideRadius = 3; 

height = 5;

centreD = 27.7;

rodLength= -propRadius - outsideRadius - 2;

$fn=50;
//comment out before rendering

rods();

//servo(false);

//gridFins();
////////////////////////////////

outside_frame();

central_platform();




module outside_frame(){
	difference() {
		ousideRim();
		mountHoles();
		rods();
	}
}

module ousideRim(){
	difference() {
		union() {
			bottomRodMount();
			cylinder(h=height, r=propRadius + outsideRadius);
			difference(){
				move(z=-5)servoMounts();
				translate([0,0,5]) cylinder(h=3, r=propRadius + outsideRadius);
			}
		}
		translate([0,0,-17]) cylinder(h=height + 18, r=propRadius);
		move(z=-5) servoSubtracts();
		
		//Cleans up sides
		difference() {
			translate([0,0,-16]) cylinder(h=height + 20, r=propRadius + outsideRadius * 4);
			translate([0,0,-16]) cylinder(h=height + 20, r=propRadius + outsideRadius);
			
		}
	}
}

module central_platform(){
	difference(){
		cylinder(h=10, d=centreD, center=true);
		rods();
		mountHoles();
	}
}

module mountHoles(){
	//M3 Mount Holes
	
	zHeight=height/2;
	angle=90;
	//Center Holes
	move( x= centreD/2  - 4,		z=zHeight, ry=angle) cylinder(h= height + 2, d=3 );
	move( x=-centreD/2 - 4, 		z=zHeight, ry=angle) cylinder(h= height + 2, d=3 );
	move( y= centreD/2  + 4,	z=zHeight, rx=angle) cylinder(h= height + 2, d=3 );
	move( y=-centreD/2 + 4, 	z=zHeight, rx=angle) cylinder(h= height + 2, d=3 );
	

	//Outside Holes
//	move(x=propRadius  - 4,	z=zHeight, ry=angle) cylinder(h= height + 2, d=3 );
//	move(x=-propRadius - 4, z=zHeight, ry=angle) cylinder(h= height + 2, d=3 );
//	move(y=propRadius  + 4,	z=zHeight, rx=angle) cylinder(h= height + 2, d=3 );
//	move(y=-propRadius + 4, z=zHeight, rx=angle) cylinder(h= height + 2, d=3 );
}

module bottomRodMount(){
	copy_mirror(x=-1, y=1){
		move(x=rodLength*sin(45), y=-rodLength*sin(45), ry=90, rz=-45) 
			cylinder(h= outsideRadius * 10 , d=9);
	}
}
module servoMounts (){
	copy_move(rz=270) {
		servoMount();
	}
}

module servoMount(){
	copy_mirror(y=1) {
		move(x=-35/2, y=-119, z=20, rx=270)
		move(z=16, x=35/2, y=35/2) resize(newsize=[34,19,4]) cylinder(h=4, d=35);
	}
}

module servoSubtracts (){
	copy_move(rz=270) {
		servoSubtract();
	}
}
module servoSubtract() {
	copy_mirror(y=1) {
		move(x=-35/2, y=-119, z=20, rx=270)
			move(z=0, x=(35 - 29.88)/2, y=(35 - 12)/2) servo(true);
	}
}

module servo(subtractHoles){
	move(x=(29.88-21.48)/2 ) //zero the servo
	difference() {	
		union() {
			move(z=20.1-3.5, x=-((29.88-21.48)/2), y=(12-9.45)/2,  ry=90) 
				cube([1.84,  9.45,  29.88]);
			cube([21.48, 12, 20.1 ]); //body
			if (subtractHoles) {
				move(x=-(29.88-21.48)/2 + 2, z=13, y=(12)/2)
					cylinder(h=10, d=2);
				move(x=21.48 + (29.88-21.48)/2 - 2, z=13, y=(12)/2)
					cylinder(h=10, d=2);
			}
		}
		
		if (!subtractHoles){
			move(x=-(29.88-21.48)/2 + 2, z=13, y=(12)/2)
				cylinder(h=4, d=2);
			move(x=21.48 + (29.88-21.48)/2 - 2, z=13, y=(12)/2)
				cylinder(h=4, d=2);
		}
	}
}	

module rods(){
	//3mm x 3mm
	rodWidthHeight=3;
	
	topZ = (height-rodWidthHeight)/2;
	bottomZ = topZ - rodWidthHeight - 2;
	echo(bottomZ);
	copy_move(z=bottomZ, rz=90){
		move(x=rodLength*sin(45) +2, y=rodLength*sin(45) , z=topZ, rz=45) 
			cube([propRadius * 2 + outsideRadius * 2 + 2 , rodWidthHeight, rodWidthHeight]);
	}
}

module gridFins(){
	copy_move(rz=90){
		copy_mirror(x=1){
			move(y=-20, x=96, z=7, ry=180) gridFin();
		}
	}
}

module copy_mirror(x=0,y=0,z=0) 
{ 
    children(); 
    mirror([x, y, z]) children(); 
} 

module copy_move(x=0,y=0,z=0,rx=0,ry=0,rz=0) { 
    children(); 
    move(x, y, z, rx, ry, rz) children(); 
} 

module move(x=0, y=0, z=0, rx=0, ry=0, rz=0) { 
	translate([x,y,z])rotate([rx,ry,rz]) children(); 
}