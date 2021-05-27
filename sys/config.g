; Communication and general
; Duet GCode: https://duet3d.dozuki.com/Wiki/Gcode
G90;
M83;
M550 P"RailCore Duet 3";
M669 K1;
G4 S1;

; Drives
; X Axis                        
M569 P0.0 S1 D3 V5 H5;
M584 X0.0;
M574 X1 S1 P"io0.in";

M350 X32 I1;
M92 X{(360 / 0.9) / (16 * 2) * 32};
M906 X{2000 * 0.67} I30
M201 X1000
M203 X{200 * 60}
M566 X{6 * 60}

; Y Axis
M569 P0.1 S0 D3 V5 H5
M584 Y0.1
M574 Y1 S1 P"121.io1.in"

M350 Y32 I1
M92 Y{(360 / 0.9) / (16 * 2) * 32}
M906 Y{2000 * 0.67} I30
M201 Y1000
M203 Y{200 * 60}
M566 Y{6 * 60}

; Z Axis 0.9 Leadscrew TR8-4
M569 P0.2 S0 D3 V5 H5                       ; Drive 0.2 goes backwards	[Front Left Z]
M569 P0.3 S0 D3 V5 H5                       ; Drive 0.3 goes backwards	[Rear Left Z]
M569 P0.4 S0 D3 V5 H5                       ; Drive 0.4 goes backwards	[Right Z]
M584 Z0.2:0.3:0.4
M574 Z1 S2

M350 Z16 I1
M92 Z{(360 / 0.9) / 4 * 16}
M906 Z{1680 * 0.67} I30
M201 Z200
M203 Z{12 * 60}
M566 Z{0.3 * 60}

; Extruder
M584 E121.0
M569 P121.0 S0 D2

M350 E16 I1
M92 E830
M906 E{1400 * 0.67} I30
M201 E5000
M203 E{120 * 60}
M566 E{3.5 * 60}
M84 S30

; Stealthchop parameters
M915 X Y S3 H402 T1                        
M915 Z S3 H532 T1
M915 P121.0 S3 H657 T20000

; Leadscrew locations
M671 X-21:-21:326 Y18:273:148 S7.5 
; Front left:(-21,18)
; Rear Left:(-21,273)
; Right (326,148)

; Axis Limits
M208 X0 Y0 Z-0.5 S1
M208 X290 Y305 Z320 S0

; BLTouch
M950 S0 C"121.io0.out"
M558 P9 C"^121.io0.in" H5 F120 T{120 * 60} A3 S0.02
G31 P500 X0 Y0 Z0
M557 X15:275 Y35:290 P3:3

; Mini IR
;M558 P1 C"io7.in" H5 F120 T{120 * 60} A3 S0.02
;G31 P500 X0 Y0 Z2.5
;M557 X15:275 Y35:290 P3:3

; Heated Bed Settings
M308 S0 P"temp0" Y"thermistor" A"Keenovo Bed" T100000 B3950
M950 H0 C"out0" T0
M307 H0 B0 R0.658 C261.0 D1.81 S1.00
M140 H0
M143 H0 S120

; Print Hed Settings
M308 S1 P"121.temp0" Y"pt1000" A"Print Head"
M950 H1 C"121.out0" T1
M307 H1 B0 R2.329 C145.7:139.2 D7.70 S1.00 V23.9
M143 H1 S300
M563 P0 S"Print Head" D0 H1 F0

;Virtual Sensor
M308 S2 P"temp2" Y"thermistor" A"Chamber-High" T100000 B3950
M308 S3 P"temp3" Y"thermistor" A"Chamber-Low" T100000 B3950

; Fans
; Part Cooling Fan
M950 F0 C"121.out1"
M106 P0 C"Part-Fan" S0 H-1

; Print Fan
M950 F1 C"121.out2"
M106 P1 C"Tool Fan" S0.5 H1 T30

; Tool definitions
G10 P0 X0 Y0 Z0
G10 P0 R0 S0
T0


; Miscellaneous
M575 P1 S1 B57600
M911 S10 R11 P"M913 X0 Y0 G91 M83 G1 Z3 E-5 F1000"

;Startup
;M98 P"/macros/Movement/XTuning"
;M98 P"/macros/Movement/YTuning"
;M98 P"/macros/Move