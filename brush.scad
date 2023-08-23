// brush automata
// belt gear
// worm gear, transmission
gear_len = 150;
gear_height = 15;
gearbox_thickness = 25;
gearbox_wall = 5;
bearing_d = 10;

gearbox();
//gearbox_wall_kit();

module gearbox_wall_kit() {
    difference() {
        gearbox_wall();
        holes_kit();
    }
}


module holes_kit() {
    bearing_hole();
    translate([0, gear_len/2 - bearing_d, 0])
    bearing_hole();
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
