
$fn=32;
d_screw_m2 = 2.6+0.3+0.2;
d_screw_m3 = 3.6+0.3;
d_side_hole = 1.6;
r_horn = 12.3+0.5;
  w_base=40;
  h_base=3;
  w_servo=12.1;
  h_servo = 16 + 0.5;
  wc_block = 16.5;
  
  w_left_edge = wc_block - w_servo;
  shift_left_edge = w_servo/2 + w_left_edge/2;
  shift_x_hole = shift_left_edge;
  shift_y_hole = w_servo/2;

  shift_wc_block = 2.4;

module holder() {
    difference(){
    cube([16.5+2, 32.2, 3],true);
    translate([9+1,15+1,0]) rotate(a=[0,0,45]) cube([4,14,5],true);
    mirror([0,1,0])
        translate([9+1,15+1,0]) rotate(a=[0,0,45]) cube([4,14,5],true);
    translate([-8-0.5,16.5+0.5,0]) rotate(a=[0,0,45]) cube([3+3,2,5],true);
    mirror([0,1,0])
        translate([-8-0.5,16.5+0.5,0]) rotate(a=[0,0,45]) cube([3+3,2,5],true);
        translate([-8-0.5,11-0.5,0]) rotate(a=[0,0,315]) cube([3+3,2,5],true);
    mirror([0,1,0])
        translate([-8-0.5,11-0.5,0]) rotate(a=[0,0,315]) cube([3+3,2,5],true);
       
    translate([-2.4-2,0,0]) cube([12.1,23,5],true);
    translate([-2.35-shift_wc_block,13.8,0])cylinder(h=5, r=1+0.3, center=true);
    mirror([0,1,0])
    translate([-2.35-shift_wc_block,13.8,0])cylinder(h=5, r=1+0.3, center=true);    
    }
}

 
holder();
