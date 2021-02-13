/* Complete X assembly */
use <x_assembly.scad>
/* Complete Y and Z assembly */
use <y_z_assembly.scad>
/* Aluminium profile */
include <parts/profile_30_dim.scad>

offset_x = 300;
offset_y = 300;
offset_z = 70;

offset_y_mount = 200;

module CNC()
{
    x_assembly(offset_x);
    translate([profile_h + offset_y_mount,0,profile_h])
    y_z_assembly(offset_y, offset_z);
}

CNC();