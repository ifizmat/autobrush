d_round = 0.5;
d_screw_m3 = 3.6+0.3;

gearbox_wall = 5;

bearing_d = 14;
hub_d = 2 * d_screw_m3;
h_tire = (bearing_d - hub_d)/2;
bearing_thick = gearbox_wall;

if (h_tire < 0) {
    echo("!!!!! h_tire<0");
}    
echo("h_tire: ", h_tire);

bearing_rounded();

module bearing_rounded() {
  tire_bearing();
  hub_bearing();
}

module tire_bearing() {
  triangle = [[-(bearing_thick/2 - d_round), 0+d_round], [0, (h_tire - d_round)], [(bearing_thick/2 - d_round), 0+d_round]];
  
  rotate_extrude(angle=360, $fn=200)
  translate([hub_d/2 - 0.5, 0, 0])
  rotate(270)
  offset(d_round, $fn=32)
  polygon(triangle);
}

module hub_bearing() {
  difference() {    
    cylinder(h = bearing_thick, d = hub_d, $fn = 32, center = true);
    cylinder(h = 2*bearing_thick, d = d_screw_m3, $fn = 32, center = true);
  }
}