include <colors.scad>
include <bom.scad>
include <sbr16uu_dim.scad>

sbr16uu_pad_w = (sbr16uu_W-sbr16uu_B);

delta = 0.1;

module sbr16uu_base()
{
    linear_extrude(sbr16uu_L, convexity = 2)
    difference()
    {
        polygon(points = [
            [2*sbr16uu_chamfer,0],
            [sbr16uu_W-2*sbr16uu_chamfer,0],
            [sbr16uu_W-sbr16uu_chamfer,sbr16uu_chamfer],
            [sbr16uu_W-sbr16uu_chamfer,sbr16uu_F - sbr16uu_T - sbr16uu_chamfer],
            [sbr16uu_W,sbr16uu_F - sbr16uu_T],
            [sbr16uu_W,sbr16uu_F - sbr16uu_chamfer],
            [sbr16uu_W-sbr16uu_chamfer,sbr16uu_F],
            [sbr16uu_W-sbr16uu_pad_w+sbr16uu_chamfer,sbr16uu_F],
            [sbr16uu_W-sbr16uu_pad_w,sbr16uu_F-sbr16uu_chamfer],
            [sbr16uu_W/2+sbr16uu_pad_w/2,sbr16uu_F-sbr16uu_chamfer],
            [sbr16uu_W/2+sbr16uu_pad_w/2-sbr16uu_chamfer,sbr16uu_F],
            [sbr16uu_W/2-sbr16uu_pad_w/2+sbr16uu_chamfer,sbr16uu_F],
            [sbr16uu_W/2-sbr16uu_pad_w/2,sbr16uu_F-sbr16uu_chamfer],
            [sbr16uu_pad_w,sbr16uu_F-sbr16uu_chamfer],
            [sbr16uu_pad_w-sbr16uu_chamfer,sbr16uu_F],
            [sbr16uu_chamfer,sbr16uu_F],
            [0,sbr16uu_F-sbr16uu_chamfer],
            [0,sbr16uu_F - sbr16uu_T],
            [sbr16uu_chamfer,sbr16uu_F - sbr16uu_T-sbr16uu_chamfer],
            [sbr16uu_chamfer,sbr16uu_chamfer],
        ]);
        translate([sbr16uu_W/2,sbr16uu_F-sbr16uu_h,0])
        {
            circle(sbr16uu_co_ext/2);
            polygon(points = [
                [0,0],
                [ sbr16uu_F*tan(sbr16uu_q/2),-sbr16uu_F],
                [-sbr16uu_F*tan(sbr16uu_q/2),-sbr16uu_F],
            ]);
        }
    }
}

module sbr16uu_insertion()
{
    translate([sbr16uu_W/2,sbr16uu_F-sbr16uu_h,sbr16uu_chamfer])
    linear_extrude(sbr16uu_L-2*sbr16uu_chamfer, convexity = 2)
    difference()
    {
        circle(sbr16uu_co_ext/2);
        circle(sbr16uu_co_int/2);
        polygon(points = [
            [0,0],
            [ sbr16uu_F*tan(sbr16uu_q/2),-sbr16uu_F],
            [-sbr16uu_F*tan(sbr16uu_q/2),-sbr16uu_F],
        ]);
    }
}

module sbr16uu_holes()
{
    translate([sbr16uu_W/2,sbr16uu_F+delta,sbr16uu_L/2])
    rotate([0,0,0])
    rotate([90,0,0])
    {
    translate([ sbr16uu_B/2,  sbr16uu_C/2,0])
    cylinder(sbr16uu_L1+delta, sbr16uu_S/2, sbr16uu_S/2);
    translate([ sbr16uu_B/2, -sbr16uu_C/2,0])
    cylinder(sbr16uu_L1+delta, sbr16uu_S/2, sbr16uu_S/2);
    translate([-sbr16uu_B/2,  sbr16uu_C/2,0])
    cylinder(sbr16uu_L1+delta, sbr16uu_S/2, sbr16uu_S/2);
    translate([-sbr16uu_B/2, -sbr16uu_C/2,0])
    cylinder(sbr16uu_L1+delta, sbr16uu_S/2, sbr16uu_S/2);
    }
}

module sbr16uu_plate_holes(dia, plate_th)
{
    translate([0,0,-delta])
    rotate([0,0,90])
    union()
    {
        translate([ sbr16uu_B/2,  sbr16uu_C/2,0])
        cylinder(plate_th+2*delta, dia/2, dia/2);
        translate([ sbr16uu_B/2, -sbr16uu_C/2,0])
        cylinder(plate_th+2*delta, dia/2, dia/2);
        translate([-sbr16uu_B/2,  sbr16uu_C/2,0])
        cylinder(plate_th+2*delta, dia/2, dia/2);
        translate([-sbr16uu_B/2, -sbr16uu_C/2,0])
        cylinder(plate_th+2*delta, dia/2, dia/2);
    }
}

module sbr16uu()
{
    translate([-sbr16uu_L/2,-sbr16uu_W/2,-sbr16uu_F+sbr16uu_h])
    rotate([0,90,0])
    rotate([0,0,90])
    {
        color("#A0A0C0")
        difference()
        {
            sbr16uu_base();
            sbr16uu_holes();
        }
        color("#808080")
        sbr16uu_insertion();
    }
    /* Screws */
    translate([ sbr16uu_C/2,  sbr16uu_B/2,sbr16uu_h])
    children(0);
    translate([ sbr16uu_C/2, -sbr16uu_B/2,sbr16uu_h])
    children(1);
    translate([-sbr16uu_C/2,  sbr16uu_B/2,sbr16uu_h])
    children(2);
    translate([-sbr16uu_C/2, -sbr16uu_B/2,sbr16uu_h])
    children(3);
    /* The rest */
    if ($children > 4)
    {
        for (i = [4:$children-1])
        {
            translate([0,0,sbr16uu_h])
                children(i);
        }
    }
    bom_item("sbr16uu");
}

module sbr16uu_spacer(h)
{
    color(color_plastic_black)
    difference()
    {
        translate([-sbr16uu_L/2,-sbr16uu_W/2+sbr16uu_chamfer,0])
        cube([sbr16uu_L,sbr16uu_W-2*sbr16uu_chamfer,h]);
        translate([0,0,-delta])
        sbr16uu_plate_holes(sbr16uu_S+1.5,h+2*delta,$fn=100);
    }    
    bom_item(str("sbr16uu_spacer_", h));
}

//sbr16uu($fn = 100)
//sbr16uu_plate_holes(3,12, $fn=30);
//sbr16uu_spacer(10);
sbr16uu()
{
    cube(1);
    cube(1);
    cube(1);
    cube(1);
}