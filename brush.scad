// brush automata
// belt gear
// worm gear, transmission
gear_len = 150;
gear_height = 15;
gearbox_thickness = 25;
gearbox_wall = 5;
bearing_d = 10;

//gearbox();

difference() {
    gearbox_wall();
    bearing_hole();
}

module gearbox() {
    translate([gearbox_thickness/2, 0, 0])
    gearbox_wall();
    mirror([1, 0, 0])
    translate([gearbox_thickness/2, 0, 0])
    gearbox_wall();
}

module gearbox_wall() {
    cube([gearbox_wall, gear_len, gear_height], true);
}

module bearing_hole() {
    rotate([0, 90, 0])
    cylinder(h = 2*gearbox_wall, d = bearing_d, $fn = 32, center = true);
}
