d_round = 0.5;
d_screw_m3 = 3.6+0.3;
screwdriver_thick = 1.5;
screwdriver_gap = 1.8 * d_screw_m3;

gear_height = 18;
gearbox_wall = 5;

bearing_d = 14;
hub_d = 2 * d_screw_m3;
h_tire = (bearing_d - hub_d)/2;
bearing_thick = gearbox_wall;

bearing_box_width = gear_height;
bearing_box_height = bearing_box_width;
bearing_box_thick = gearbox_wall;

if (h_tire < 0) {
    echo("!!!!! h_tire<0");
}    
echo("h_tire: ", h_tire);

translate([0,0,2*bearing_box_thick])
bearing_box();
linear_extrude(bearing_box_thick)
    offset(delta=1.2*bearing_d/2, chamfer=true)
    square(bearing_box_width-1.2*bearing_d, true);   
//bearing_rounded();
//translate([bearing_box_width, 0, 0])
//cutset_bearing_box();

module cutset_bearing_box() {
  difference() {
    union() {
      color("lime")
      bearing_box();
      bearing_rounded();
    }
    translate([0, -bearing_box_width/2, 0])
    cube([bearing_box_width+1, bearing_box_height, bearing_box_thick+1], true);
  }  
}

module bearing_rounded() {
  tire_bearing();
  hub_bearing();
}

module tire_bearing() {
  triangle = [[-(bearing_thick/2 - d_round), 0+d_round], [0, (h_tire - d_round)], [(bearing_thick/2 - d_round), 0+d_round]];
  
  rotate_extrude(angle=360, $fn=100)
  translate([hub_d/2 - 0.5, 0, 0])
  rotate(270)
  offset(d_round, $fn=32)
  polygon(triangle);
}

module hub_bearing() {
  difference() {    
    cylinder(h = bearing_thick, d = hub_d, $fn = 32, center = true);
    cylinder(h = 2*bearing_thick, d = d_screw_m3, $fn = 32, center = true);
    // Screwdriver gap
    rotate([0, 0, 90])
    cube([screwdriver_gap, screwdriver_thick, bearing_box_thick+1], true);

  }
}


module bearing_box(){
  difference() {
    cube([bearing_box_width, bearing_box_height, bearing_box_thick], true);
    scale(0.95)
    hole_bearing();
  }
}

module bearing_box_chamfer(){
  difference() {
    linear_extrude(bearing_box_thick)
    offset(delta=1.2*bearing_d/2, chamfer=true)
    square(bearing_box_width-1.2*bearing_d, true);   scale(0.95)
    hole_bearing();
  }
}

module hole_bearing() {
  rotate_extrude(angle=360, $fn=100)
  union() {
    translate([bearing_d/2 - bearing_box_thick/2, 0, 0])
    circle(d=bearing_box_thick, $fn=64);
    translate([(bearing_d/2-bearing_box_thick/2)/2, 0, 0])
    square([bearing_d/2-bearing_box_thick/2, bearing_box_thick], center=true);
  }
  cylinder(h=bearing_thick+2, d=1.65*hub_d, center=true, $fn=64);
}








