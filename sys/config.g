; Communication and general
M111 S0                     ; Debug off
M550 P"RailCore"	    ; Machine name and Netbios name (can be anything you like)
M551 P"GGamer1894@!"    ; Machine password (used for FTP)
M552 S1				    ; Enable WiFi
M586 P0 S1              ; Enable HTTP
M586 P1 S1              ; Enable FTP
M586 P2 S1              ; Enable Telnet
M555 P2                 ; Set compatibility [S2:Marlin]
M575 P1 B57600 S1       ; Set serial comms parameters [Channel (P)1, (B)aud Rate:57600, (S)1:PanelDue mode, checksum required]
G21                     ; Set Units to Millimeters
G90                     ; Set to Absolute Positioning
M83                     ; Set extruder to relative mode
M669 K1				    ; Select CoreXY

; XY Axis
M584 X0 Y1              ; Set drive mapping X to drive 0, Y to drive 1
M569 P0 S0              ; Drive 0 goes forwards [X-Axis, Rear Motor]
M569 P1 S0              ; Drive 1 goes forwards [Y-Axis, Front motor]
M350 X16 Y16 I1	        ; Set 16x microstepping w/ interpolation
M92 X200 Y200	        ; Set axis steps per unit, X/Y may be more around 201.5 for accuracy
M906 X1426 Y1426 I60    ; Set motor currents (mA)
; Kinematics
M201 X3000 Y3000        ; Accelerations (mm/s^2)
M203 X24000 Y24000      ; Maximum speed [400mm/sec]
M566 X900 Y900          ; Maximum jerk speeds [15mm/sec]

; Z Axis
M584 Z5:6:7             ; Set drive mapping Z to drive 5, 6, and 7 for DueX5
M569 P5 S0			    ; Drive 5 goes backwards	[Front Left Z]
M569 P6 S0			    ; Drive 6 goes backwards	[Rear Left Z]
M569 P7 S0			    ; Drive 7 goes backwards	[Right Z]
M350 Z16 I1	            ; Set 16x microstepping w/ interpolation
M92 Z1600	            ; Set axis steps per unit
M906 Z1426 I60	        ; Set motor currents (mA)
; Kinematics
M201 Z100               ; Accelerations (mm/s^2)
M203 Z900               ; Maximum speed [15mm/sec]
M566 Z90                ; Maximum jerk speed [1.5mm/sec]


; Extruder
M584 E3                 ; Set drive mapping extruder (E0) to drive 3
M569 P3 S1              ; Drive 3 goes forwards
M350 E16 I1	            ; Set 16x microstepping w/ interpolation
M92 E830	            ; Set axis steps per unit
M906 E938 I60	        ; Set motor currents (mA)
; Kinematics
M201 E1500              ; Accelerations (mm/s^2)
M203 E3600              ; Maximum speed [60mm/sec]
M566 E1500              ; Maximum jerk speed  [25mm/sec]

M84 S30                 ; Set idle timeout


; Leadscrew locations
M671 X-10:-10:333 Y22.5:277.5:150 S7.5 
; Front left:(-10,22.5)
; Rear Left:(-10.,227.5)
; Right (333,160) 
; S7.5 is the max correction - measure your own offsets, to the bolt for the yoke of each leadscrew

; Endstops
M574 X1 P"xstop" S1     ; Configure active-high endstop for low end on X via pin xstop
M574 Y1 P"ystop" S1	    ; Configure active-high endstop for low end on Y via pin ystop
M574 Z1 S2              ; Configure Z-probe endstop for low end on Z

M208 X290 Y290 Z280 S0  ; Set axis max travel
M208 X0 Y0 Z-0.5 S1     ; Set axis min travel [Adjust to make X=0 and Y=0 the edges of the bed]

; Heated Bed Settings
M308 S0 P"bedtemp" Y"thermistor" A"Top-Bed_Temp" T100000 B3950 C0 R4700
M950 H0 C"bedheat" T0                                   ; Create bed heater
M307 H0 A240.3 C608.7 D8.2 B0 S1.00 V0                  ; Set heating process parameters [H0:Bed, ACD, (B)angBang: Disabled, PWM:1.0]
M143 H0
M143 H0 S80                                             ; Maximum H0 (Bed) heater temperature (Conservative)
; M140 S-273 R-273                                      ; Standby and initial Temp for bed as "off" (-273 = "off")

; Print Hed Settings
M308 S1 "spi.cs1" Y"rtd-max31865" A"Print-Head_Temp"
M950 H1 C"e0heat" T1                                    ; Create bed heater
M307 H1 A270.7 C90.4 D6.7 B0 S1.00 V24.0                ; Set heating process parameters [H1:Print-Head, ACD, (B)angBang: Disabled, PWM:1.0]
M143 H1 S300                                            ; Maximum H1 (Extruder) heater temperature
M570 S360				                                ; Print will be terminated if a heater fault is not reset within 360 minutes.

; Fans
; Part Cooling Fan
M950 F0 C"fan0" Q500            ; Create fan 0 on pin fan0 and set its frequency
M106 P0 S0 H-1 C"Part-Fan"      ; Set fan 0 name, value, PWM signal inversion and frequency. Thermostatic control is turned off
; Print Fan
M950 F1 C"fan1" Q500            ; Create fan 1 on pin fan1 and set its frequency
M106 P1 S1 H1 T45 C"Tool-Fan"   ; Set fan 1 name, value, PWM signal inversion and frequency. Thermostatic control is turned off

; Tool definitions
M563 P0 S"Print-Head" D0 H1 F0  ; Define tool 0
G10 P0 X0 Y0 Z0                 ; Set tool 0 axis offsets
G10 P0 R0 S0                    ; Set initial tool 0 active and standby temperatures to 0C
T0					            ; Select Tool 0

; IR Sensor
; M558 P1 F120 H5 T6000 A5 S0.02 C"^zprobe.in"  ; Z probe is an IR probe and is not used for homing any axes
; G31 X0 Y30 Z2.00 P500			                ; Set Probe status, offsets
; M557 X15:215 Y15:195 S20                      ; Define mesh grid

; BLTouch
; M950 S0 C"duex.pwm1"
; M558 P9 F50 H5 T6000 A5 S0.02 C"^zprobe.in"   ; Set Z probe type [P9:BLTouch, (F)eedrate:50, Dive-(H)eight:5mm, (T)ravel:6000, 5 probes per point, 0.02 tolerance]
; G31 P25 X2 Y42 Z2.65                          ; Set Z probe trigger value, offset and trigger height
; M557 X15:215 Y15:195 S20                      ; Define mesh grid