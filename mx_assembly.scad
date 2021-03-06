/* MX screw */
use     <parts/mx_screw_lens_hex.scad>
/* MX washer */
use     <parts/mx_washer.scad>
include <parts/mx_washer_dim.scad>
/* Nut 8 B */
use     <parts/nut8b.scad>

module mx_assembly(head_off, nut_off, reverse = 0){
    translate([0,0,-nut_off*reverse])
    rotate([180*reverse,0,0])
    {
        if ($children > 0)
        {
            translate([0,0,head_off])
            {
                children(0);
                if ($children > 1)
                {
                    children(1);
                }
            }
        }
        if ($children > 2)
        {
            translate([0,0,-nut_off])
            children(2);
        }
    }
}


// Sample usage
dia = 6;
mx_assembly(MX_WASHER_th[dia],10,0)
{
    mx_screw_lens_hex(dia, 30);
    mx_washer(dia);
    nut8b(dia);
}