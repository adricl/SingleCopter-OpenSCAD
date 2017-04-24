propRadius = 101.6; //4 inches

outsideRadius = 2; 

height = 5;

centreD = 27.7;

rodLength= -propRadius - outsideRadius - 2;

//$fn=50;
//comment out before rendering

rods();

//servo();

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
		}
		translate([0,0,-10]) cylinder(h=height + 11, r=propRadius);
		difference() {
			translate([0,0,-5]) cylinder(h=height + 10, r=propRadius + outsideRadius * 4);
			translate([0,0,-6]) cylinder(h=height + 12, r=propRadius + outsideRadius);
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
	move(x=propRadius  - 4,	z=zHeight, ry=angle) cylinder(h= height + 2, d=3 );
	move(x=-propRadius - 4, z=zHeight, ry=angle) cylinder(h= height + 2, d=3 );
	move(y=propRadius  + 4,	z=zHeight, rx=angle) cylinder(h= height + 2, d=3 );
	move(y=-propRadius + 4, z=zHeight, rx=angle) cylinder(h= height + 2, d=3 );
}

module bottomRodMount(){
	copy_mirror(x=-1, y=1){
		move(x=rodLength*sin(45), y=-rodLength*sin(45), ry=90, rz=-45) 
			cylinder(h= outsideRadius * 10 , d=9);
	}
}

module servo(){
	difference() {	
		union() {
			move(z=14.35, x=-((29.88-21.48)/2), y=( 12-9.45)/2,  ry=90) cube([1.84,  9.45,  29.88]);
			cube([21.48, 12, 20.1 ]); //body
		}
		
		move(x=-(29.88-21.48)/2 + 2, z=11.35, y=(12)/2)
			cylinder(h=4, d=2);
		move(x=21.48 + (29.88-21.48)/2 - 2, z=11.35, y=(12)/2)
			cylinder(h=4, d=2);
	}
}	

module rods(){
	//3mm x 3mm
	rodWidthHeight=3;
	
	topZ = (height-rodWidthHeight)/2;
	bottomZ = topZ - rodWidthHeight - 2;
	
	copy_move(z=bottomZ, rz=90){
		move(x=rodLength*sin(45) +2, y=rodLength*sin(45) , z=topZ, rz=45) 
			cube([propRadius * 2 + outsideRadius * 2 + 2 , rodWidthHeight, rodWidthHeight]);
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