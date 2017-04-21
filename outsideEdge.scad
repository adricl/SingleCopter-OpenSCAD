propRadius = 101.6; //4 inches

outsideRadius = 2; 

height = 5;

copy_mirror(vec=[0,180,0]){
	rods();
}

difference() {
	cylinder(h=height, r=propRadius + outsideRadius);
	translate([0,0,-2]) cylinder(h=height + 4, r=propRadius);
	mountHoles();
}

module mountHoles(){
	//M3 Mount Holes
	
	zHeight=height/2;
	angle=90;
	move(x=propRadius  - 4,	z=zHeight, ry=angle) cylinder(h= height + 2, d=3 );
	move(x=-propRadius - 4, z=zHeight, ry=angle) cylinder(h= height + 2, d=3 );
	move(y=propRadius  + 4,	z=zHeight, rx=angle) cylinder(h= height + 2, d=3 );
	move(y=-propRadius + 4, z=zHeight, rx=angle) cylinder(h= height + 2, d=3 );
}

module rods(){
	//3mm x 3mm
	rodWidthHeight=3;
	lenght=-propRadius - outsideRadius - 1;
	
	move(x=lenght*sin(45) +2, y=lenght*sin(45), z=(height-rodWidthHeight)/2, rz=45) 
		cube([propRadius * 2 + outsideRadius * 2 , rodWidthHeight, rodWidthHeight]);
}



module copy_mirror(vec=[0,0,0]) 
{ 
    children($children-1); 
    mirror(vec) children(); 
} 
module move(x=0,y=0,z=0,rx=0,ry=0,rz=0)
{ translate([x,y,z])rotate([rx,ry,rz]) children(); }