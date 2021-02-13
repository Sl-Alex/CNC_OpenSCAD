include <colors.scad>
include <bom.scad>
include <sbr16_dim.scad>

sbr16_F_off = (sbr16_Y-sbr16_T)*cos(60)/2;
delta = 0.01;

module sbr16_shaft(length)
{
    color("#A0A090")
    translate([sbr16_B/2,sbr16_h,-delta])
    cylinder(length+2*delta, sbr16_D/2, sbr16_D/2);
}

module sbr16_base(length)
{
    color(color_alu)
    linear_extrude(length)
    polygon(points = [
        [0,0],
        [(sbr16_B-sbr16_F)/2,0],
        [(sbr16_B-sbr16_F)/2+1,1],
        [sbr16_B - (sbr16_B-sbr16_F)/2 - 1,1],
        [sbr16_B - (sbr16_B-sbr16_F)/2,0],
        [sbr16_B,0],
        [sbr16_B,sbr16_T],
        [sbr16_B-(sbr16_B-sbr16_F)/2,sbr16_T],
        [sbr16_B-(sbr16_B-sbr16_F)/2,sbr16_Y],
        [sbr16_B-(sbr16_B-sbr16_F)/2-sbr16_F_off,sbr16_Y],
        [sbr16_B/2,sbr16_Y+(((sbr16_B-sbr16_F)/2)-sbr16_F_off)*tan(60)],
        [(sbr16_B-sbr16_F)/2+sbr16_F_off,sbr16_Y],
        [(sbr16_B-sbr16_F)/2,sbr16_Y],
        [(sbr16_B-sbr16_F)/2,sbr16_T],
        [(sbr16_B-sbr16_F)/2,sbr16_T],
        [0,sbr16_T]]);
}

module sbr16_base_old(length)
{
    linear_extrude(length)
    polygon(points = [
        [0,0],
        [(sbr16_B-sbr16_Fb)/2,0],
        [(sbr16_B-sbr16_Fb)/2+1,1],
        [sbr16_B - (sbr16_B-sbr16_Fb)/2 - 1,1],
        [sbr16_B - (sbr16_B-sbr16_Fb)/2,0],
        [sbr16_B,0],
        [sbr16_B,sbr16_T],
        [sbr16_B-(sbr16_B-sbr16_Ft)/2,sbr16_T],
        [sbr16_B/2,sbr16_T+((sbr16_B-sbr16_Ft)/2)*tan(60)],
        [(sbr16_B-sbr16_Ft)/2,sbr16_T],
        [0,sbr16_T]]);
}

module sbr16(length)
{
    translate([0,-sbr16_B/2,0])
    rotate([0,0,90])
    rotate([90,0,0])
    {
        sbr16_base(length);
        sbr16_shaft(length);
    }
    bom_item(str("sbr16x", length));
}
