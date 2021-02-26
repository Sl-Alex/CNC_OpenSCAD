/* Complete Y plate assembly */
use     <plate_y_assembly.scad>
include <parts/plate_y_dim.scad>
/* Z plate */
use     <parts/plate_z.scad>
include <parts/plate_z_dim.scad>
/* scj16uu holes */
use <parts/scj16uu.scad>
include <parts/scj16uu_dim.scad>

include <CNC_dim.scad>
include <parts/sk16_dim.scad>

use <parts/spindle_holder.scad>
include <parts/spindle_holder_dim.scad>

use <parts/spindle.scad>
use <parts/milling_cutter.scad>

/* Metric screw */
use <mx_assembly.scad>
/* MX washer */
use     <parts/mx_washer.scad>
include <parts/mx_washer_dim.scad>
/* MX nut */
use     <parts/mx_nut.scad>

module spindle_holder_mx_assembly()
{
    mx_assembly(6,75,MX_WASHER_th[6],spindle_holder_hole_z+plate_z_th+MX_WASHER_th[6])
    {
        mx_washer(6);
        group()
        {
            translate([0,0,MX_WASHER_th[6]])
            mx_washer(6);
            mx_nut(6);
        }
    }
}

/* Complete Y and Z assembly */
module plate_y_z_assembly(offset)
{
    /* Plate Y assembly */
    plate_y_assembly(offset)
    {
        translate([0,0,0.1])
        /* Plate Z */
        plate_z()
        {
            translate([scj16uu_L/2+sk16_B,-plate_y_w/2+sk16_W/2,0])
            scj16uu_plate_holes(6, plate_z_th+2);

            translate([scj16uu_L/2+sk16_B+z_sbr16sajuu_distance,-plate_y_w/2+sk16_W/2,0])
            scj16uu_plate_holes(6, plate_z_th+2);
            translate([scj16uu_L/2+sk16_B,plate_y_w/2-sk16_W/2,0])
            scj16uu_plate_holes(6, plate_z_th+2);
            translate([scj16uu_L/2+sk16_B+z_sbr16sajuu_distance,plate_y_w/2-sk16_W/2,0])
            scj16uu_plate_holes(6, plate_z_th+2);

            rotate([0,0,90])
            translate([0,-plate_z_l+spindle_holder_y/2,plate_z_th])
                spindle_holder_plate_holes(6.5, plate_z_th);
        }
        
        rotate([0,0,90])
        translate([0,-plate_z_l+spindle_holder_y/2,plate_z_th])
        spindle_holder_assembly()
        {
            translate([0,-20,0])
            rotate([-90,0,0])
            spindle()
            {
                milling_cutter($fn=100);
            }
            spindle_holder_mx_assembly();
            spindle_holder_mx_assembly();
            spindle_holder_mx_assembly();
            spindle_holder_mx_assembly();
        }
    }
}

//plate_y_z_assembly((0.5-0.5*cos($t*360))*74);
plate_y_z_assembly(10, $fn=30);

