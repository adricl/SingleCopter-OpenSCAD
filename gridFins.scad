
//Total Shape
height=20;
width=35;
length=100;

//Wall Thickness
thickness=2;

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

color("red") mountHoles();

difference() {
	box();
	ductMiddle();
	sideDucts();
	mountHoles();
}


module box(){
	difference() {
		cube([length, width, height]);
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
	translate([ -1, thickness + (ductWidth/2) ,thickness]) mountHole();
	translate([ -1, thickness * 2 + ductWidth/2 + ductWidth ,thickness]) mountHole();
	translate([ -1, thickness * 3 + ductWidth/2 + ductWidth * 2 ,thickness]) mountHole();
	
	translate([ -1, thickness * 2 + ductWidth/2 + ductWidth ,thickness]) mountHole();
}

module mountHole() {
	subtractThickness= thickness +2;
	echo(holeSize);
	rotate(a=90, v=[0,1,0]) cylinder(r=holeSize/2, h=subtractThickness );
}
