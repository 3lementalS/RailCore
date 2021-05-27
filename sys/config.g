; Communication and general
; Duet GCode: https://duet3d.dozuki.com/Wiki/Gcode
G90                                         ; send absolute coordinates...
M83                                         ; ...but relative extruder moves
M550 P"RailCore"                            ; set printer name
M669 K1                                     ; select CoreXY mode

; Drives
; X Axis                                    ; https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCoreXYPrinter
M569 P0.0 S1 D3 V5 H5                       ; Drive 0.0 goes forwards [X-Axis, Rear Motor]
M584 X0.0                                   ; Set drive mapping X to drive 0
M574 X1 S1 P"io1.in"                        ; configure active-high endstop for low end on X via pin io1.in

M350 X16 I1	                                ; Set 16x microstepping w/ interpolation
M92 X{(360 / 0.9) / (16 * 2) * 16}          ; Set axis steps per unit [steps per unit = (steps per rotation) / (tooth count * belt pitch) * microstep]
M906 X{2000 * 0.67} I30                     ; Set motor currents (mA)
M201 X1000                                  ; Accelerations (mm/s^2)
M203 X{200 * 60}                            ; Maximum speed
M566 X{6 * 60}                              ; Maximum jerk speeds

; Y Axis                                    ; https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCoreXYPrinter
M569 P0.1 S0 D3 V5 H5                       ; Drive 0.1 goes goes backwards [Y-Axis, Front Motor]
M584 Y0.1                                   ; Set drive mapping Y to drive 1
M574 Y1 S1 P"io0.in"                        ; configure active-high endstop for low end on Y via pin io0.in

M350 Y16 I1	                                ; Set 16x microstepping w/ interpolation
M92 Y{(360 / 0.9) / (16 * 2) * 16}          ; Set axis steps per unit [steps per unit = (steps per rotation) / (tooth count * belt pitch) * microstep]
M906 Y{2000 * 0.67} I30                     ; Set motor currents (mA)
M201 Y1000                                  ; Accelerations (mm/s^2)
M203 Y{200 * 60}                            ; Maximum speed
M566 Y{6 * 60}                              ; Maximum jerk speeds

; Z Axis 0.9 Leadscrew TR8-4
M569 P0.2 S0 D3 V5 H5                       ; Drive 0.2 goes backwards	[Front Left Z]
M569 P0.3 S0 D3 V5 H5                       ; Drive 0.3 goes backwards	[Rear Left Z]
M569 P0.4 S0 D3 V5 H5                       ; Drive 0.4 goes backwards	[Right Z]
M584 Z0.2:0.3:0.4                           ; Set drive mapping Z to drive 2, 3, 4
M574 Z1 S2                                  ; configure Z-probe endstop for low end on Z

M350 Z16 I1	       		                    ; Set 16x microstepping w/ interpolation
M92 Z{(360 / 0.9) / 4 * 16}	      	        ; ; Set axis steps per unit [steps per unit = (steps per rotation) / lead * microstep]
M906 Z{1680 * 0.67} I30	                    ; Set motor currents (mA)
M201 Z200                                   ; Accelerations (mm/s^2)
M203 Z{12 * 60}                             ; Maximum speed
M566 Z{0.3 * 60}                            ; Maximum jerk speed [0.3mm/sec]

; Extruder
M584 E0.5                                   ; Set drive mapping extruder (E0) to drive 5
M569 P0.5 S0 D2                             ; Drive 5 goes backwards

M350 E16 I1	        	                    ; Set 16x microstepping w/ interpolation
M92 E830	        	                    ; Set axis steps per unit
M906 E{1400 * 0.67} I30	                    ; Set motor currents (mA)
M201 E5000            	                    ; Accelerations (mm/s^2)
M203 E{120 * 60}                            ; Maximum speed
M566 E{3.5 * 60}              	            ; Maximum jerk speed
M84 S30                                     ; Set idle timeout

; Stealthchop parameters
M915 P0.0:0.1 S3 H402 T1                        
M915 P0.2:0.3:0.4 S3 H532 T1
M915 P0.5 S3 H657 T20000

; Leadscrew locations
M671 X-21:-21:326 Y18:273:148 S7.5 
; Front left:(-21,18)
; Rear Left:(-21,273)
; Right (326,148)

; Axis Limits
M208 X0 Y0 Z-0.5 S1                         ; set axis min
M208 X290 Y305 Z320 S0                      ; set axis max

; BLTouch
M950 S0 C"io7.out"                                 ; create servo pin 0 for BLTouch
M558 P9 C"^io7.in" H5 F120 T{120 * 60} A3 S0.02    ; Set Z probe type [P9:BLTouch, (F)eedrate:120, Dive-(H)eight:5mm, (T)ravel:7200mm/min, 3 probes per point, 0.02mm tolerance]
G31 P500 X0 Y0 Z0                                  ; Set Z probe trigger value, offset and trigger height
M557 X15:275 Y35:290 P3:3                          ; Define mesh grid

; Mini IR
;M558 P1 C"io7.in" H5 F120 T{120 * 60} A3 S0.02     ; Set Z probe type [P1:MiniIR, (F)eedrate:120mm/min, Dive-(H)eight:5mm, (T)ravel:7200mm/min, 3 probes per point, 0.02mm tolerance]
;G31 P500 X0 Y0 Z2.5                                ; Set Z probe trigger value, offset and trigger height
;M557 X15:275 Y35:290 P3:3                          ; Define mesh grid

; Heated Bed Settings
M308 S0 P"temp0" Y"thermistor" A"Keenovo" T100000 B3950                 ; configure sensor 0 as thermistor on pin temp0
M950 H0 C"out0" T0                                                      ; create bed heater output on out0 and map it to sensor 0
M307 H0 B0 R0.658 C261.0 D1.81 S1.00                                  	; Set heating process parameters [H0:Bed, RCD, (B)angBang: Disabled, PWM:1.0]
M140 H0							                                        ; Define bed
M143 H0 S120                                                            ; set temperature limit for heater 0 to 120C

; Print Hed Settings
M308 S1 P"temp1" Y"pt1000" A"Print Head"                                ; configure sensor 0 as PT1000 on pin temp1
M950 H1 C"out1" T1                                                      ; create nozzle heater output on out1 and map it to sensor 1
M307 H1 B0 R2.329 C145.7:139.2 D7.70 S1.00 V23.9				        ; Set heating process parameters [H1:Print-Head, ACD, (B)angBang: Disabled, PWM:1.0]
M143 H1 S300                                                            ; set temperature limit for heater 1 to 300C
M563 P0 S"Print Head" D0 H1 F0                                          ; define tool 0

;Virtual Sensor
M308 S2 P"temp2" Y"thermistor" A"Chamber-High" T100000 B3950
M308 S3 P"temp3" Y"thermistor" A"Chamber-Low" T100000 B3950

; Fans
; Part Cooling Fan
M950 F0 C"out8" Q500                ; create fan 0 on pin out8 and set its frequency
M106 P0 C"Part-Fan" S0 H-1          ; set fan 0 name and value. Thermostatic control is turned off

; Print Fan
M950 F1 C"out7" Q25000                    ; create fan 1 on pin out7 and set its frequency
M106 P1 C"Tool-Fan" S0.70 H1 T45        ; set fan 1 name and value. Thermostatic control is turned on

; Tool definitions
G10 P0 X0 Y0 Z0   ; set tool 0 axis offsets
G10 P0 R0 S0      ; set initial tool 0 active and standby temperatures to 0C
T0                ; Select Tool 0


; Miscellaneous
M575 P1 S1 B57600                                           ; enable support for PanelDue
M911 S10 R11 P"M913 X0 Y0 G91 M83 G1 Z3 E-5 F1000"          ; set voltage thresholds and actions to run on power loss

;Startup
;M98 P"/macros/Movement/XTuning"
;M98 P"/macros/Movement/YTuning"
;M98 P"/macros/Movement/ZTuning"