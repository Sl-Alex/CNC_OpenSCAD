include <colors.scad>
include <bom.scad>
include <plate_z_dim.scad>

module plate_z()
{
    difference()
    {
        translate([0,-plate_z_w/2,0])
        color(color_alu)
        cube([plate_z_l,plate_z_w,plate_z_th]);

        if ($children > 0)
        {
            for (i = [0:$children-1])
            {
                translate([0,0,0])
                    children(i);
            }
        }
    }

	bom_item(str("plate_z_",plate_z_l,"x",plate_z_w,"x",plate_z_th));
}