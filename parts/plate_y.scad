include <colors.scad>
include <bom.scad>
include <plate_y_dim.scad>

module plate_y()
{
    difference()
    {
        translate([0,-plate_y_w/2,0])
        color(color_alu)
        cube([plate_y_l,plate_y_w,plate_y_th]);

        if ($children > 0)
        {
            for (i = [0:$children-1])
            {
                translate([0,0,0])
                    children(i);
            }
        }
    }

    bom_item(str("plate_y_",plate_y_l,"x",plate_y_w,"x",plate_y_th));
}

plate_y();