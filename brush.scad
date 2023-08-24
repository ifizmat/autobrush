// brush automata
// belt gear
// worm gear, transmission
gear_len = 80;
gear_height = 15;
gearbox_thickness = 25;
gearbox_wall = 5;
bearing_d = 10;

gearbox();
//translate([-40, 0, 0])
//gearbox_wall_kit();

module gearbox_wall_kit() {
    difference() {
        gearbox_wall();
        holes_kit();
    }
}


module holes_kit() {
// servo
    translate([0, gear_len/2 - bearing_d, 0])
    bearing_hole();
// belt gear wheel master    
    translate([0, gear_len/2 - 2.5*bearing_d, 0])
    bearing_hole();
// belt gear wheel slave    
    translate([0, -gear_len/2 + 3*bearing_d, 0])
    bearing_hole();
// brush wheel
    translate([0, -gear_len/2 + bearing_d, 0])
    bearing_hole();
    translate([0, -gear_len/2, 0])
    cube([gearbox_wall + 2, 2*bearing_d, bearing_d], true);
}

module gearbox() {
    translate([gearbox_thickness/2, 0, 0])
    //gearbox_wall();
    gearbox_wall_kit();
    mirror([1, 0, 0])
    translate([gearbox_thickness/2, 0, 0])
    //gearbox_wall();
    gearbox_wall_kit();
}

module gearbox_wall() {
    cube([gearbox_wall, gear_len, gear_height], true);
}

module bearing_hole() {
    rotate([0, 90, 0])
    cylinder(h = 2*gearbox_wall, d = bearing_d, $fn = 32, center = true);
}
