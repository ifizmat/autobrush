d_bearing  = 10+0.3;
d_cylinder = 15+10;
h_cylinder = 10-5;
h_bottom   = 3;
width_wall_x = 4;
width_wall_y = 6;
d_side_hole = 2.1;
d_central_hole = 7;
r_horn_x = 6.4;
r_horn_y = 6.4;
deep_hole_mask = 3;
d_screw_m3 = 3.8;

module hole_mask() {
translate([0, 0, deep_hole_mask]) rotate([0, 0, 45])
  cube([1.6*width_wall_y, 1.6*width_wall_y, h_cylinder+1], center = true);
translate([0, 0, deep_hole_mask]) rotate([0, 0, 0])
cube([width_wall_x, d_cylinder+5, h_cylinder+1], center = true);
translate([0, 0, deep_hole_mask]) rotate([0, 0, 0])
cube([d_cylinder+5, width_wall_y, h_cylinder+1], center = true);

translate([0, r_horn_y, 0])
  cylinder(d=d_side_hole, h=2*h_cylinder+6, center=true, $fn=16);
translate([r_horn_x,0, 0])
  cylinder(d=d_side_hole, h=2*h_cylinder+6, center=true, $fn=16);    
translate([0, -r_horn_y, 0])
  cylinder(d=d_side_hole, h=2*h_cylinder+6, center=true, $fn=16);    
translate([-r_horn_x, 0, 0])
  cylinder(d=d_side_hole, h=2*h_cylinder+6, center=true, $fn=16);    
translate([0, 0, 0])
  cylinder(d=d_screw_m3, h=2*h_cylinder+6, center=true, $fn=16);
//  cylinder(d=d_central_hole, h=2*h_cylinder+6, center=true, $fn=16);
//translate([0, 0, (h_cylinder+3-h_cylinder)])
//  #cylinder(d=d_bearing, h=2*h_cylinder+6, center=true, $fn=32);    

}

module hole_head_screw1(){
  cylinder(d = 8, h = 3 + 1, center=true, $fn=16);
  translate([0, 0, -(3 + 0.5)])
    cylinder(d1 = 1, d2 = 6, h = 3 + 1, center=true, $fn=16);  
}

module hole_head_screw1(){
  cylinder(d = 8, h = 3 + 1, center=true, $fn=16);
  translate([0, 0, -(3 + 0.5)])
    cylinder(d1 = 1, d2 = 6, h = 3 + 1, center=true, $fn=16);  
}

module hole_head_screw2(){
  translate([0, r_horn_y, -4 + 0.35])
   cylinder(d=3*d_side_hole, h = 2 + 0.35, center=true, $fn=16);
}

module hole_head_screw3(){
  hole_head_screw2();
  mirror([0, 1, 0])
    hole_head_screw2();
  mirror([1, 1, 0])
    hole_head_screw2();
  mirror([1, 0, 0])
    mirror([1, 1, 0])
      hole_head_screw2();
}

module support_hole_head_screw2(){
  translate([0, r_horn_y, -4 + 0.35 + -0])
    cylinder(d=3*d_side_hole-0.7, h=2-0.35, center=true, $fn=16);
}

module support_hole_head_screw3(){

  support_hole_head_screw2();
  mirror([1, 1, 0])
    support_hole_head_screw2();
  mirror([0, 1, 0])
    support_hole_head_screw2();
  mirror([1, 0, 0])
    mirror([1, 1, 0])
      support_hole_head_screw2();
}

module barrel() {
cylinder(d=d_cylinder, h=h_cylinder, center=true, $fn=64);
translate([0, 0, h_cylinder/2+1])
  cylinder(d1=d_cylinder, d2=d_cylinder - 2, h=2, center=true, $fn=32);
mirror([0,0,1])
  translate([0, 0, h_cylinder/2+1])
    cylinder(d1=d_cylinder, d2=d_cylinder - 2, h=2, center=true, $fn=32);}

module wheel1() {
difference() {

 barrel();
    translate([0, 0, h_bottom])
      hole_mask();
  translate([0, 0, h_cylinder - (3 + 1)/2])
    hole_head_screw1();
  hole_head_screw3();
  }
}


difference() {
wheel1();
//translate([16, 0, 0])
//cube([20, 20, 15], true);
}
support_hole_head_screw3();
//hole_head_screw1();
//hole_head_screw2();