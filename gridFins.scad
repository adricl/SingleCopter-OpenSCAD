use <MCAD/boxes.scad>
//Total Shape
height=15;
width=40;
length=80;

//Wall Thickness
thickness=1.5;

ductWidths = width - (thickness*4);
ductWidth=ductWidths/3;

ductHeightBottom = -1;
ductHeightTop = height + 2;

//M3
holeSize = 3;

//Front Corners
angle = 25;
subLength = length/3;
subWidth = width * (2/3);
$fn=50;

//servoScrewHole();

//move(rz=45) 
	gridFin();

//servoMount();

module gridFin() {
		difference() {
			box();
			ductMiddle();
			mountHoles();
			sideDucts();
		}
		translate([ 0, thickness * 2 + ductWidth/2 + ductWidth ,5]) servoScrewHole();
}

module box(){
	
	difference() {
		translate([length/2, width/2, height/2]) 
			roundedBox([length, width, height], 2, false );

		subBoxes();
	}
}

module subBoxes() {
	subBox(0);
	translate([ 0, width, 0 ]) mirror([0,1,0]) subBox(0);
}

module subBox(ductWidth) {
	translate([length - sin(angle)*subLength, -cos(angle)*subWidth + ductWidth, -1]) 
	rotate(a=[0, 0, angle])  
	cube([ subLength +1, subWidth , ductHeightTop]);
}

module ductMiddle(){
		translate([thickness, ductWidth + thickness * 2 ,-1]) 
		cube([length - (2*thickness), ductWidth, ductHeightTop]);
}

module sideDucts(){
	sideDuct();
	translate([0, ductWidth * 3 + thickness * 4, 0]) 
		mirror([0,1,0])
		sideDuct();
}

module sideDuct(){
	ductLength = length - (2*thickness);
	
	difference() {
		translate([thickness, thickness, -1]) 
			cube([ductLength, ductWidth, ductHeightTop]);
		subBox(thickness);
	}
}

module mountHoles() {
	holeHeight = 5;
	translate([ -1, thickness + (ductWidth/2) ,holeHeight]) mountHole();
	translate([ -1, thickness * 2 + ductWidth/2 + ductWidth ,holeHeight]) rotate(a=90, v=[0,1,0]) cylinder(d=3.7, h=3.5);
	translate([ -1, thickness * 3 + ductWidth/2 + ductWidth * 2 ,holeHeight]) mountHole();
	
	translate([ length - thickness - 1, thickness * 2 + ductWidth/2 + ductWidth ,holeHeight]) mountHole();
}

module mountHole() {
	subtractThickness= thickness +2;
	echo(holeSize);
	rotate(a=90, v=[0,1,0]) cylinder(r=holeSize/2, h=subtractThickness );
}

module servoScrewHole () {
	screwWidth=2;
	servoMountHeight=2.5;
	servoWidth=3.7;
	thickness=3;	
	rotate(a=90, v=[0,1,0])
		difference() {
			cylinder(d = servoWidth+thickness, h=servoMountHeight+1);
			move(z=-1) cylinder(d=servoWidth, h=servoMountHeight+1);
			move(z=servoMountHeight - 1) cylinder(d=screwWidth, h=servoMountHeight+1);
		}
}

//module servoMount()
//{
//	longLength=28.78;
//	longWidth=3.8;
//	shortLength=16.85;
//	shortWidth=4.8;
//	midWidth=5.35;
//	height = 5;
//	
////	move(y=longLength/2) 
////	hull() {
////		move(x=shortWidth/2, y=shortWidth/2)
////			cylinder(d=shortWidth, h=height);
////		move(x=shortWidth/2 + shortLength - shortWidth, y=shortWidth/2 )
////			cylinder(d=shortWidth, h=height);
////	}
//
////move(x= shortLength/2 - longWidth/2)
////	copy_move(rz=180){
//		hull() {
//			move(x= longWidth/2, y= longWidth/2) 
//				cylinder(d= longWidth, h=height);
//			move(x= longWidth/2, y= longWidth/2 + longLength/2 - longWidth/2) 
//				cylinder(d= midWidth , h=height);
//		}
//		move() hull() {
//			move(x=longWidth/2, y= longWidth/2) 
//				cylinder(d= midWidth , h=height);
//			move(x= longWidth/2, y= longWidth/2 + longLength/2 - longWidth/2) 
//				cylinder(d= longWidth, h=height);
//			}
//}

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