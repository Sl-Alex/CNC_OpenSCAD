/* Shaft */
use     <parts/shaft.scad>
/* Shaft support */
use     <parts/sk16.scad>
include <parts/sk16_dim.scad>

shaft_dia = 16;

/* Shaft with supports */
module sk16_assembly(len)
{

    /* Shaft */
    translate([0,0,sk16_h])
    shaft(shaft_dia,len);
    /* First support */
    sk16();
    /* Second support */
    translate([len-sk16_B,0,0])
    sk16();
}

sk16_assembly(100);