// brush automata
// belt gear
// worm gear, transmission

use <servo_holder.scad>
use <sg90.scad>
use <servo_wheel.scad>
use <bearing.scad>

d_screw_m3 = 3.6+0.3;

d_brush = 35;
len_brush = 140;
len_shaft_brush = len_brush + 20; 
d_shaft_brush = d_screw_m3;

gear_len = 80;
gear_height = 18;
gearbox_width = len_shaft_brush;
holder_thickness = 3;
gearbox_wall = 5;
bearing_d = 14;

cap_depth = gear_height/2 - bearing_d/2  + bearing_d/4; 
cap_width = bearing_d - 1;

// Проушины моста
len_lugs = 4 * d_screw_m3;

d_rounded_bearing = 1;

brush_shaft();
// master wheel
rotate([0, 90, 0])
cylinder(h = 10,d = 20, center=true, $fn=64);
brush_kit();
// rounded_bearing()
// servo_box();
module rounded_bearing() {
  rotate([0, 90, 0])
  rotate_extrude(angle=360, $fn=64)
  translate([bearing_d/2 - d_rounded_bearing/2, 0, 0])
  circle(d = d_rounded_bearing, $fn=64);
  bearing();
}

// Servo holder
//translate([gearbox_width/2, 0, 10])
// bearing();
// gearbox_wall_kit();

//translate([-40, 0, 0])
//gearbox_wall_kit();
//translate([0, -10, 0])
//holder_bearing();
//servo_holes();

// cap_bridge_VER1();
 

module brush_kit() {

  gearbox();
  
  translate([-gearbox_width/2+5, gear_len/2 + 6.6, 0])
  servo_box();
  
  translate([0, -gear_len/2 + bearing_d, 0])
  brush_assembly();
}

module gearbox() {
    translate([gearbox_width/2, 0, 0])
    //gearbox_wall();
    gearbox_wall_kit();
    translate([0, -gear_len/2 + bearing_d, gear_height/2 - cap_depth/2])
    cap_kit();
    mirror([1, 0, 0])
    translate([gearbox_width/2, 0, 0])
    //gearbox_wall();
    gearbox_wall_kit();
}

module gearbox_wall_kit() {
  difference() {
      gearbox_wall();
      holes_kit();
  }

  // bearing belt gear wheel master    
  translate([0, gear_len/2 - 1.5*bearing_d, 0])
  {
    rotate([0, 90, 0])
    bearing_rounded();
    //bearing();
    //holder_bearing();
  }

  // bearing for belt gear wheel  slave    
  translate([0, -gear_len/2 + 3*bearing_d, 0])
  {
    bearing();
    holder_bearing();
  }

  // brush bearing
  translate([0, -gear_len/2 + bearing_d, 0])
  bearing();
}

module servo_box() {
    translate([-13.5, 0, 0])
    rotate([0, -90, 180])
    sg90();
    difference() {
        translate([0, -4.5, 0])
        rotate([0, 90, 0])
        rotate([0, 0, -90])
        holder();
        translate([-4, -10.3, 0])
        servo_holes();
    }
    
    translate([20, 0, 5.5])
    wheel_kit();
}

module wheel_kit() {
    rotate([0, -90, 0])
    wheel1();
}

module holder_bearing() {
  difference() {
    cube([3*gearbox_wall, 3*d_screw_m3, gear_height+2*d_screw_m3], true);
  
  // Holes for shaft  
    cube([4*gearbox_wall, d_screw_m3, gear_height - d_screw_m3], true);
    translate([0, 0, gear_height/2 - d_screw_m3/2])
    rotate([0, 90, 0])
    cylinder(h=5*gearbox_wall, d=d_screw_m3, center=true, $fn=32);
    mirror([0, 0, 1])
    translate([0, 0, gear_height/2 - d_screw_m3/2])
    rotate([0, 90, 0])
    cylinder(h=5*gearbox_wall, d=d_screw_m3, center=true, $fn=32);
  // Hole for wall
    translate([0, 0, -d_screw_m3/2-0.5])
    cube([gearbox_wall, 2*bearing_d, gear_height+d_screw_m3+1], true);
  }
}

module brush_assembly() {
  #brush();
  brush_shaft();
}

module brush() {
  rotate([0, 90, 0])
  cylinder(d=d_brush, h=len_brush, center=true);
}

module brush_shaft() {
  rotate([0, 90, 0])
  cylinder(d=d_shaft_brush, h=len_shaft_brush, center=true);
}

module cap_bridge_VER1() {
translate([0, -gear_len/2 + bearing_d, gear_height/2 - cap_depth/2])
cap_kit();
gearbox_wall_kit();
translate([0, -gear_len/2 + bearing_d, 0])
translate([0, 0, - gear_height/2 - gearbox_wall/2])
cube([gearbox_width + gearbox_wall + len_lugs, cap_width, gearbox_wall], true);
}


module bearing() {
  difference() {    
    rotate([0, 90, 0])
    cylinder(h = gearbox_wall, d = bearing_d - 1, $fn = 32, center = true);

    rotate([0, 90, 0])
    cylinder(h = 2*gearbox_wall, d = d_screw_m3, $fn = 32, center = true);
  }
}

module cap_kit() {
    translate([gearbox_width/2, 0, 0])
    cap();

    mirror([1, 0, 0])
    translate([gearbox_width/2, 0, 0])
    cap();
    
// Cap bridge.
    difference() {
      translate([0, 0, cap_depth/2 + gearbox_wall/2])
      cube([gearbox_width + gearbox_wall + len_lugs, cap_width, gearbox_wall], true);

      // holes
      translate([(gearbox_width + gearbox_wall + len_lugs)/2 - 1.2*d_screw_m3, 0, cap_depth])
      cylinder(h = 2*gearbox_wall + 2*holder_thickness, d = d_screw_m3, $fn = 32, center = true);
      mirror([1, 0, 0])
      translate([(gearbox_width + gearbox_wall + len_lugs)/2 - 1.2*d_screw_m3, 0, cap_depth])
      cylinder(h = 2*gearbox_wall + 2*holder_thickness, d = d_screw_m3, $fn = 32, center = true);
    }
}

// cap
module cap() {
  difference() {
    cube([gearbox_wall, cap_width, cap_depth], true);
    cap_hole();
  }      
}

module cap_hole() {
    translate([0, 0, -bearing_d/2 - cap_depth/2 + bearing_d/4])
    rotate([0, 90, 0])
    cylinder(h = 2*gearbox_wall, d = bearing_d, $fn = 32, center = true);
}


module holes_kit() {
// Servo holder
    translate([0, gear_len/2 - d_screw_m3, 0])    
    servo_holes();
// servo
//    translate([0, gear_len/2 - bearing_d, 0])
//    bearing_hole();
// belt gear wheel master    
    translate([0, gear_len/2 - 1.5*bearing_d, 0])
    bearing_hole();
// belt gear wheel slave    
    translate([0, -gear_len/2 + 3*bearing_d, 0])
    bearing_hole();
// brush wheel
    translate([0, -gear_len/2 + bearing_d, 0])
    bearing_hole();

// Version 1: brush hole - forward.
//    translate([0, -gear_len/2, 0])
//    cube([gearbox_wall + 2, 2*bearing_d, bearing_d], true);

// Version 2: brush hole - up.   
    translate([0, -gear_len/2 + bearing_d, gear_height/2])
    cube([gearbox_wall + 2, bearing_d, 2*bearing_d ], true);
   
}

module bearing_hole() {
    rotate([0, 90, 0])
    cylinder(h = 2*gearbox_wall, d = bearing_d, $fn = 32, center = true);
}


module gearbox_wall() {
    cube([gearbox_wall, gear_len, gear_height], true);
}


module servo_holes() {
    translate([0, 0, gear_height/2 - d_screw_m3])
    rotate([0, 90, 0])
    cylinder(h = 2*gearbox_wall + 2*holder_thickness, d = d_screw_m3, $fn = 32, center = true);
    mirror([0, 0, 1])
    translate([0, 0, gear_height/2 - d_screw_m3])
    rotate([0, 90, 0])
    cylinder(h = 2*gearbox_wall + 2*holder_thickness, d = d_screw_m3, $fn = 32, center = true);
}



