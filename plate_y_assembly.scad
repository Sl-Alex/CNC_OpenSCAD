/* Step motor */
use     <parts/motor.scad>
include <parts/motor_dim.scad>
/* Motor holder Z */
use     <parts/motor_z.scad>
include <parts/motor_z_dim.scad>
/* Y plate */
use     <parts/plate_y.scad>
include <parts/plate_y_dim.scad>
/* Ball screw assembly */
use     <sfu1605_assembly.scad>
include <parts/bk12_dim.scad>
/* Shaft with supports */
use     <sk16_assembly.scad>
include <parts/sk16_dim.scad>
/* Linear bearing */
use     <parts/scj16uu.scad>
include <parts/scj16uu_dim.scad>
/* Spider coupling */
use     <parts/shaft_coupling_spider.scad>

/* Global CNC dimensions */
include <CNC_dim.scad>

/* Linear bearings */
module z_sbr16uu_assembly(offset)
{
    scj16uu_offset_def = scj16uu_L/2+sk16_B;
    sk16_assembly(z_shaft_len);
    translate([scj16uu_offset_def+offset,0,sk16_h])
    scj16uu();
    translate([scj16uu_offset_def+z_sbr16sajuu_distance+offset,0,sk16_h])
    scj16uu();
}

/* Complete Y plate assembly */
module plate_y_assembly(offset)
{
    /* Base plate */
    plate_y();
    /* Z motor holder */
    translate([-motor_z_th,0,bk12_h+plate_y_th])
    motor_z();
    /* Z motor */
    translate([-motor_z_th,0,bk12_h+plate_y_th])
    {
        motor();
        translate([motor_shaft_l,0,0])
        shaft_coupling_spider(8,10,15, $fn = 50);
    }
    /* sfu1605 assembly */
    translate([z_ballscrew_offset,0,plate_y_th])
    sfu1605_assembly(z_ballscrew_len, offset);

    /* Shaft with supports and bearings */
    translate([plate_y_l-z_shaft_len, plate_y_w/2-sk16_W/2,plate_y_th])
    z_sbr16uu_assembly(offset);
    /* Shaft with supports and bearings */
    translate([plate_y_l-z_shaft_len,-plate_y_w/2+sk16_W/2,plate_y_th])
    z_sbr16uu_assembly(offset);
    
    /* Translate all children (Z plate should be there)*/
    if ($children > 0)
    {
        for (i = [0:$children-1])
        {
            translate([plate_y_l-z_shaft_len+offset,0,plate_y_th+sk16_h+scj16uu_h])
                children(i);
        }
    }
}

plate_y_assembly(70);
