; Communication and general
; Duet GCode: https://duet3d.dozuki.com/Wiki/Gcode
M111 S0                 ; Debug off
M550 P"RailCore"		; Machine name and Netbios name (can be anything you like)
;M551 P"GGamer1894@!"	; Machine password (used for FTP)
M552 S1					; Enable WiFi
M586 P0 S1              ; Enable HTTP
M586 P1 S1              ; Enable FTP
M586 P2 S1              ; Enable Telnet
M555 P2                 ; Set compatibility [S2:Marlin]
M575 P1 B57600 S1       ; Set serial comms parameters [Channel (P)1, (B)aud Rate:57600, (S)1:PanelDue mode, checksum required]
G21                     ; Set Units to Millimeters
G90                     ; Set to Absolute Positioning
M83                     ; Set extruder to relative mode
M669 K1					; Select CoreXY

; XY Axis               ; https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCoreXYPrinter
M584 X0 Y1              ; Set drive mapping X to drive 0, Y to drive 1
M569 P0 S0              ; Drive 0 goes forwards [X-Axis, Rear Motor]
M569 P1 S1              ; Drive 1 goes backwards [Y-Axis, Front motor]
M350 X16 Y16 I1	        ; Set 16x microstepping w/ interpolation
M92 X200 Y200	        ; Set axis steps per unit, X/Y may be more around 201.5 for accuracy
M906 X840 Y840 I60    	; Set motor currents (mA) 50%
;M906 X1006 Y1006 I60   ; Set motor currents (mA) 60%
;M906 X1126 Y1126 I60   ; Set motor currents (mA) 67%
;M906 X1428 Y1428 I60   ; Set motor currents (mA) 85%
; Kinematics
M201 X3000 Y3000        ; Accelerations (mm/s^2)
M203 X18000 Y18000      ; Maximum speed [300mm/sec]
M566 X600 Y600          ; Maximum jerk speeds [10mm/sec]

; Z Axis 0.9 2-Start Leadscrew TR8-4
M584 Z5:6:7             ; Set drive mapping Z to drive 5, 6, and 7 for DueX5
M569 P5 S0				; Drive 5 goes backwards	[Front Left Z]
M569 P6 S0				; Drive 6 goes backwards	[Rear Left Z]
M569 P7 S0				; Drive 7 goes backwards	[Right Z]
M350 Z16 I1	       		; Set 16x microstepping w/ interpolation
M92 Z1600	      		; Set axis steps per unit
M906 Z840 I60	        ; Set motor currents (mA) 50%
;M906 Z1008 I60	        ; Set motor currents (mA) 60%
;M906 Z1126 I60	        ; Set motor currents (mA) 67%
;M906 Z1428 I60	        ; Set motor currents (mA) 85%
; Kinematics
M201 Z100               ; Accelerations (mm/s^2)
M203 Z900               ; Maximum speed [15mm/sec]
M566 Z100               ; Maximum jerk speed [0.2mm/sec]

; Extruder
M584 E3                 ; Set drive mapping extruder (E0) to drive 3
M569 P3 S0              ; Drive 3 goes backwards
M350 E16 I1	        	; Set 16x microstepping w/ interpolation
M92 E830	        	; Set axis steps per unit
M906 E938 I60	        ; Set motor currents (mA)
; Kinematics
M201 E10000            	; Accelerations (mm/s^2)
M203 E3600              ; Maximum speed [60mm/sec]
M566 E120              	; Maximum jerk speed  [2mm/sec]

M84 S30                 ; Set idle timeout


; Leadscrew locations
M671 X-21:-21:326 Y18:273:148 S7.5 
; Front left:(-21,18)
; Rear Left:(-21,273)
; Right (326,148)

; Endstops
M574 X1 P"xstop" S1     ; Configure active-high endstop for low end on X via pin xstop
M574 Y1 P"ystop" S1		; Configure active-high endstop for low end on Y via pin ystop
M574 Z1 S2              ; Configure Z-probe endstop for low end on Z

M208 X290 Y305 Z320 S0  ; Set axis max travel
M208 X0 Y0 Z-0.5 S1     ; Set axis min travel [Adjust to make X=0 and Y=0 the edges of the bed]

; Heated Bed Settings
M308 S0 P"bedtemp" Y"thermistor" A"Keenovo" T100000 B3950 R4700 H0 L0
M950 H0 C"bedheat" T0                                   ; Create bed heater
M307 H0 A239.3 C431.9 D1.0 B0 S1.00 V0                  ; Set heating process parameters [H0:Bed, ACD, (B)angBang: Disabled, PWM:1.0]
M143 H0 S80                                             ; Maximum H0 (Bed) heater temperature (Conservative)
; M140 S-273 R-273                                      ; Standby and initial Temp for bed as "off" (-273 = "off")

; Print Hed Settings
M308 S1 P"spi.cs1" Y"rtd-max31865" A"Print-Head_Temp"
M950 H1 C"e0heat" T1                                    ; Create bed heater
M307 H1 A243.5 C96.5 D1.7 B0 S1.00 V24.2				; Set heating process parameters [H1:Print-Head, ACD, (B)angBang: Disabled, PWM:1.0]
M143 H1 S350                                            ; Maximum H1 (Extruder) heater temperature
;M570 S360				                				; Print will be terminated if a heater fault is not reset within 360 minutes.

; Fans
; Part Cooling Fan
M950 F0 C"fan0" Q500            ; Create fan 0 on pin fan0 and set its frequency
M106 P0 S0 H-1 C"Part-Fan"      ; Set fan 0 name, value, PWM signal inversion and frequency. Thermostatic control is turned off
; Print Fan
M950 F1 C"fan1" Q500            ; Create fan 1 on pin fan1 and set its frequency
M106 P1 S1 H1 T45 C"Tool-Fan"   ; Set fan 1 name, value, PWM signal inversion and frequency. Thermostatic control is turned on

; Tool definitions
M563 P0 S"Print-Head" D0 H1 F0  ; Define tool 0
M140 H0							; Define bed
G10 P0 X0 Y0 Z0                 ; Set tool 0 axis offsets
G10 P0 R0 S0                    ; Set initial tool 0 active and standby temperatures to 0C
T0								; Select Tool 0

; IR Sensor
; M558 P1 F120 H5 T6000 A5 S0.02 C"^zprobe.in"  ; Z probe is an IR probe and is not used for homing any axes
; G31 X0 Y30 Z2.00 P500							; Set Probe status, offsets
; M557 X15:280 Y35:260 P20                      ; Define mesh grid

; BLTouch
M950 S0 C"duex.pwm1"
M558 P9 F120 H5 T7200 A5 S0.02 C"^zprobe.in"   	; Set Z probe type [P9:BLTouch, (F)eedrate:120, Dive-(H)eight:5mm, (T)ravel:7200mm/min, 3 probes per point, 0.02mm tolerance]
G31 P25 X-2 Y33.5 Z2.851						; Set Z probe trigger value, offset and trigger height
M557 X15:280 Y35:260 P3:3                      	; Define mesh grid

; Custom settings
M81												; ATX Power Off

; Soft Power Control
; Input
M950 J0 C"^duex.gp1"	;
; Output 
M950 P1 C"duex.gp2"		;
; Trigger
M581 P1 T2				;

;Virtual Sensor
M308 S3 P"duex.e2temp" Y"thermistor" A"Chamber" T100000 B3950 R4700 H0 L0

; Configuration file for Duet 3 (firmware version 3)
; executed by the firmware on start-up
;
; generated by RepRapFirmware Configuration Tool v3.2.3 on Sun Mar 07 2021 14:32:50 GMT-0800 (Pacific Standard Time)

; General preferences
G21
G90                                                ; send absolute coordinates...
M83                                                ; ...but relative extruder moves
M550 P"Duet 3"                                     ; set printer name
M669 K1                                            ; select CoreXY mode

; Drives
M569 P0.0 S1                                       ; physical drive 0.0 goes forwards
M569 P0.1 S0                                       ; physical drive 0.1 goes backwards
M569 P0.2 S0                                       ; physical drive 0.2 goes backwards
M569 P0.5 S0                                       ; physical drive 0.5 goes backwards
M584 X0.0 Y0.1 Z0.2 E0.5                           ; set drive mapping
M350 X16 Y16 Z16 E16 I1                            ; configure microstepping with interpolation
M92 X200.00 Y200.00 Z1600.00 E830.00               ; set steps per mm
M566 X600.00 Y600.00 Z12.00 E120.00                ; set maximum instantaneous speed changes (mm/min)
M203 X18000.00 Y18000.00 Z900.00 E7200.00          ; set maximum speeds (mm/min)
M201 X3000.00 Y3000.00 Z100.00 E10000.00           ; set accelerations (mm/s^2)
M906 X840 Y840 Z840 E938 I30                       ; set motor currents (mA) and motor idle factor in per cent
M84 S30                                            ; Set idle timeout

; Axis Limits
M208 X0 Y0 Z-0.5 S1                                ; set axis minima
M208 X290 Y305 Z320 S0                             ; set axis maxima

; Endstops
M574 X1 S1 P"io1.in"                               ; configure active-high endstop for low end on X via pin io1.in
M574 Y1 S1 P"io2.in"                               ; configure active-high endstop for low end on Y via pin io2.in
M574 Z1 S2                                         ; configure Z-probe endstop for low end on Z

; Z-Probe
M950 S0 C"io7.out"                                 ; create servo pin 0 for BLTouch
M558 P9 C"^io7.in" H5 F7200 T6000                  ; set Z probe type to bltouch and the dive height + speeds
G31 P500 X-2 Y33.5 Z0                              ; set Z probe trigger value, offset and trigger height
M557 X5:288 Y35:270 S20                            ; define mesh grid

; Heaters
M308 S0 P"temp0" Y"thermistor" T100000 B3950       ; configure sensor 0 as thermistor on pin temp0
M950 H0 C"out0" T0                                 ; create bed heater output on out0 and map it to sensor 0
M307 H0 B0 S1.00                                   ; disable bang-bang mode for the bed heater and set PWM limit
M140 H0                                            ; map heated bed to heater 0
M143 H0 S80                                        ; set temperature limit for heater 0 to 80C
M308 S1 P"spi.cs0" Y"rtd-max31865"                 ; configure sensor 1 as thermocouple via CS pin spi.cs0
M950 H1 C"out1" T1                                 ; create nozzle heater output on out1 and map it to sensor 1
M307 H1 B0 S1.00                                   ; disable bang-bang mode for heater  and set PWM limit
M143 H1 S300                                       ; set temperature limit for heater 1 to 300C

; Fans
M950 F0 C"out5" Q500                               ; create fan 0 on pin out5 and set its frequency
M106 P0 C"Part Fan" S0 H-1                         ; set fan 0 name and value. Thermostatic control is turned off
M950 F1 C"out4" Q500                               ; create fan 1 on pin out4 and set its frequency
M106 P1 C"Tool Fan" S1 H1:2 T45                    ; set fan 1 name and value. Thermostatic control is turned on

; Tools
M563 P0 S"Print Head" D0 H1 F0                     ; define tool 0
G10 P0 X0 Y0 Z0                                    ; set tool 0 axis offsets
G10 P0 R0 S0                                       ; set initial tool 0 active and standby temperatures to 0C

; Custom settings are not defined

; Miscellaneous
M575 P1 S1 B57600                                  ; enable support for PanelDue
M911 S10 R11 P"M913 X0 Y0 G91 M83 G1 Z3 E-5 F1000" ; set voltage thresholds and actions to run on power loss
T0                                                 ; select first tool