// Caption: Isometric Shapes
// Version: 1.1.0
// Authors: Michael Horvath
// Website: http://isometricland.net/
// Created: 2008-06-22
// Updated: 2019-12-02
// This file is licensed under the terms of the CC-LGPL.
// Render this scene at 97x112px.

#include "ShapeGrid_macro.inc"
#include "functions.inc"
#include "math.inc"
#include "finish.inc"
#include "transforms.inc"
#include "Axes_macro.inc"
#local show_grid = 0;

//------------------------------
// Scenery

global_settings
{
	assumed_gamma 1.0
	ambient_light 1.0		// was 0.3
//	radiosity {brightness 0.3}
}

//background {rgb 0}

union
{
	light_source
	{
		-x*100
		color rgb 4/4		// was 2/4
		shadowless
		parallel
		point_at <0,0,0>	// was not specified
	}
	rotate		-z*60
	rotate		-y*30
	rotate		-y*90
}

union
{
	light_source
	{
		-x*100
		color rgb 4/4		// was 2/4
		shadowless
		parallel
		point_at <0,0,0>	// was not specified
	}
	rotate		-z*60
	rotate		+y*60
	rotate		-y*90
}

camera
{
	#local CameraDistance	= 1000;			// was 10
//	#local ScreenArea	= sqrt(2*pow(1,2)) * 4/10 * 1;
//	#local AspectRatio	= 2*cos(2*pi/12) * 1/1;
	#local ScreenArea	= sqrt(2*pow(1,2)) * 4/10 * 1;
	#local AspectRatio	= 2*cos(2*pi/12) * 1/2;
	orthographic
	location	-z*CameraDistance
	direction	+z*CameraDistance
	right		+x*ScreenArea
	up			+y*ScreenArea/AspectRatio
//	rotate +x*90
	rotate +x*asind(tand(30))
//	rotate +x*30
	rotate +y*45
}

//------------------------------
// the coordinate grid and axes
#if (show_grid)
	Axes_Macro
	(
		10,		// Axes_axesSize:	The distance from the origin to one of the grid's edges.	(float)
		0.1,	// Axes_majUnit:	The size of each large-unit square.	(float)
		5,		// Axes_minUnit:	The number of small-unit squares that make up a large-unit square.	(integer)
		0.0005,	// Axes_thickRatio:	The thickness of the grid lines (as a factor of axesSize).	(float)
		off,	// Axes_aBool:		Turns the axes on/off. (boolian)
		on,		// Axes_mBool:		Turns the minor units on/off. (boolian)
		off,	// Axes_xBool:		Turns the plane perpendicular to the x-axis on/off.	(boolian)
		on,		// Axes_yBool:		Turns the plane perpendicular to the y-axis on/off.	(boolian)
		off		// Axes_zBool:		Turns the plane perpendicular to the z-axis on/off.	(boolian)
	)
	
	object
	{
		Axes_Object
		translate 0.000001
	//	no_reflection
	}
#end

//------------------------------
// CSG objects

#declare SphereObject_Object = sphere {0, 1}

#declare SphereObject_Intersection = intersection
{
	plane {+z, 0 rotate y * 0}
	plane {-y, 0 rotate z * 0}
	plane {+x, 0 rotate y * 0}
}

#declare BasicObject_Pigment = texture
{
	pigment {color srgb <4/4,4/4,4/4,>}
	finish
	{
//		Phong_Glossy
		ambient 1/3			// was 2/4
//		diffuse albedo 1	// was not specified
	}
}


//------------------------------
// Example in an intersection

difference
{
	box {-1/2, +1/2}	// was box {0,1}
	texture {BasicObject_Pigment}
//	rotate	+y * 180
	scale	1/10
//	no_reflection
}