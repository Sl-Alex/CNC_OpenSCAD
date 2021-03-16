include <colors.scad>
include <bom.scad>

module plate_base(l,w,th)
{
    difference()
    {
        translate([0,-w/2,0])
        color(color_alu)
        cube([l,w,th]);

        if ($children > 0)
        {
            for (i = [0:$children-1])
            {
                translate([0,0,0])
                    children(i);
            }
        }
    }
    

}

module plate_x(l,w,th)
{
    plate_base(l,w,th);
    bom_item(str("plate_x_",l,"x",w,"x",th));
}

module plate_y(l,w,th)
{
    plate_base(l,w,th);
    bom_item(str("plate_y_",l,"x",w,"x",th));
}

module plate_z(l,w,th)
{
    plate_base(l,w,th);
    bom_item(str("plate_z_",l,"x",w,"x",th));
}

plate_x(200,100,10,$fn=30)
{
    translate([10,10,-1])
    cylinder(h=plate_x_th+2, r = 3, center = false);
    translate([10,-10,-1])
    cylinder(h=plate_x_th+2, r = 3, center = false);
}
