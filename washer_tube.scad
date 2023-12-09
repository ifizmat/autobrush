h_tube = 25;
d_tube = 7;
r_round = 2;
wall_thickness = 1.5;
r_round_wall = wall_thickness/2;
h_cyl = h_tube - r_round_wall;

r_tor = d_tube/2 - r_round_wall;

d_screw_hole = 3.5;
len_srew = d_tube + 4;
d_groove = d_tube/2 + 2.2;
r_round_groove = 3;

module tor() {
  translate([0, 0, r_round_wall])
  rotate_extrude($fn = 64)
  translate([r_tor, 0, 0])
  circle(r = r_round_wall, $fn = 32);
}

module tor_groove() {
  
  rotate_extrude($fn = 64)
  translate([d_groove, 0, 0])
  circle(r = r_round_groove, $fn = 32);
}


module base() {
    //translate([0, 0, r_round])
    cylinder(d = d_tube, h = h_cyl, $fn = 64 );    
}


module section() {
    difference() {
        square(r_round);
        translate([r_round, r_round, 0])
        circle(r = r_round, $fn = 32);
    }
}

module base2() {
    base();
    rotate_extrude($fn = 64)
    translate([d_tube/2, 0, 0])
    section();
}


module tube() {
    translate([0, 0, h_cyl - r_round_wall])
    tor();
    difference() {
        base2();
        translate([0, 0, -2])
        cylinder(d = d_tube - 2*wall_thickness, h = h_tube + 4, $fn = 64 );    
    }
}

module set_screw_holes() {
    rotate([90, 0, 0])
    cylinder(d = d_screw_hole, h = len_srew, center = true, $fn = 32);
    rotate([0, 90, 0])
    cylinder(d = d_screw_hole, h = len_srew, center = true, $fn = 32);
}

module tube_holed() {
    difference() {
        tube();
        translate([0, 0, h_cyl - d_screw_hole])
        set_screw_holes();
    }
}

module tube_grooved() {
    difference() {
        tube_holed();
        translate([0, 0, h_cyl - d_screw_hole])
        tor_groove();
    }
}

module washer_base() {
  difference() {
    cylinder(d=18, h=2.5, center=true, $fn=64);
    cylinder(d=d_tube-2*wall_thickness, h=5, center=true, $fn=64);
    translate([0, 0, -2.5/2-0.1])
    rotate_extrude($fn = 64)
    translate([(d_tube-2*wall_thickness)/2-0.1, 0, 0])
    section();
    
  }
}



tube();
translate([0, 0, -2.5/2])
washer_base();
//tube_grooved();
//tube_holed();
//translate([0, 0, 0])
//color("red")
//cylinder(d = d_tube, h = h_tube);
//base();

//translate([0, 0, h_tube])
//tor_groove();
//base();