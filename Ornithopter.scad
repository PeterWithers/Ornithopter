/*
 * Copyright (C) 2013 Peter Withers
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

wingSpan = 80;
fuselageLength = 80;
fuselageWidth = 5;
fuselageHeight = 20;
fingerThickness = 2;
axilDiameter = 1.2;
wingLength = (wingSpan - fuselageWidth) / 2;

module makeWing() {
    translate([fuselageWidth,0,0]) {
        cube([wingLength, fingerThickness, fingerThickness]);
        cube([fingerThickness, fuselageLength, fingerThickness]);
    }
    // make the loop
    translate([wingLength*0.3,fingerThickness/2,fingerThickness+axilDiameter]){
        //translate([0,(-fuselageHeight/2)+fingerThickness,0])
        rotate([-90,0,0])difference(){
            cylinder(h=fingerThickness,r=axilDiameter+fingerThickness,center=true);
            cylinder(h=fingerThickness*2,r=axilDiameter,center=true);
        }
    }
}

module makeFuselage(){
    translate([0,fuselageLength/2,fuselageHeight/2]){
        difference(){
            cube([fuselageWidth, fuselageLength, fuselageHeight], center=true);
            union()rotate([-90,0,0]){
                // bore the hole for the axil
                translate([0,(-fuselageHeight/2)+fingerThickness,0])cylinder(h=fuselageLength*2,r=axilDiameter,center=true);
                // make an opening for the rubber band to be placed
                rotate([0,90,0])translate([0,(-fuselageHeight/1.5)+fingerThickness,0])scale([1,0.45,1])cylinder(h=fuselageWidth*2, r=fuselageLength/2.2,center=true);
            }
        }
    }
}

module makeOrnithopter(){
	makeFuselage();
	makeWing();
	scale([-1,1,1]) makeWing();
}

makeOrnithopter();