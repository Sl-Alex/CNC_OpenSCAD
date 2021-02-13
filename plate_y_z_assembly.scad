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

/* Complete Y and Z assembly */
module plate_y_z_assembly(offset)
{
    /* Plate Y assembly */
    plate_y_assembly(offset)
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
    }
}

//plate_y_z_assembly((0.5-0.5*cos($t*360))*74);
plate_y_z_assembly(10, $fn=30);