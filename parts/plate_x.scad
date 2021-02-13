include <colors.scad>
include <bom.scad>
include <plate_x_dim.scad>

module plate_x(plate_x_l,plate_x_w)
{
    difference()
    {
        translate([0,-plate_x_w/2,0])
        color(color_alu)
        cube([plate_x_l,plate_x_w,plate_x_th]);

        if ($children > 0)
        {
            for (i = [0:$children-1])
            {
                translate([0,0,0])
                    children(i);
            }
        }
    }
    

	bom_item(str("plate_x_",plate_x_l,"x",plate_x_w,"x",plate_x_th));
}

plate_x(200,100, $fn=30)
{
    translate([10,10,-1])
    cylinder(h=plate_x_th+2, r = 3, center = false);
    translate([10,-10,-1])
    cylinder(h=plate_x_th+2, r = 3, center = false);
}
