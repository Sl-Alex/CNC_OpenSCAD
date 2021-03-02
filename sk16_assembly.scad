/* Shaft */
use     <parts/shaft.scad>
/* Shaft support */
use     <parts/sk16.scad>
include <parts/sk16_dim.scad>

shaft_dia = 16;

/* Shaft with supports */
module sk16_assembly(len)
{
    /* First support with shaft */
    sk16(){
        shaft(shaft_dia,len);
        if ($children > 0)
        children(0);
        if ($children > 1)
        children(1);
    }
    /* Second support */
    translate([len-sk16_B,0,0])
    sk16()
    {
        group(){}
        if ($children > 0)
        children(0);
        if ($children > 1)
        children(1);
    }
}

sk16_assembly(100);