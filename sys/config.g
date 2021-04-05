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

; X Axis                            ; https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCoreXYPrinter
M584 X0                             ; Set drive mapping X to drive 0, Y to drive 1
M569 P0 S0                          ; Drive 0 goes forwards [X-Axis, Rear Motor]
M350 X16 I1	                        ; Set 16x microstepping w/ interpolation
M92 X{(360 / 0.9) / (16 * 2) * 16}  ; Set microsteps
M906 X{2000 * 0.67} I30             ; Set motor currents (mA)
M201 X1000                          ; Accelerations (mm/s^2)
M203 X{120 * 60}                    ; Maximum speed
M566 X{6 * 60}                      ; Maximum jerk speeds

; Y Axis                            ; https://duet3d.dozuki.com/Wiki/ConfiguringRepRapFirmwareCoreXYPrinter
M584 Y1                             ; Set drive mapping X to drive 0, Y to drive 1
M569 P1 S1                          ; Drive 1 goes backwards [Y-Axis, Front motor]
M350 Y16 I1	                        ; Set 16x microstepping w/ interpolation
M92 Y{(360 / 0.9) / (16 * 2) * 16}  ; Set microsteps
M906 Y{2000 * 0.67} I30             ; Set motor currents (mA)
M201 Y1000                          ; Accelerations (mm/s^2)
M203 Y{120 * 60}                    ; Maximum speed
M566 Y{6 * 60}                      ; Maximum jerk speeds

; Z Axis 0.9 2-Start Leadscrew TR8-4
M584 Z5:6:7                             ; Set drive mapping Z to drive 5, 6, and 7 for DueX5
M569 P5 S0				                ; Drive 5 goes backwards	[Front Left Z]
M569 P6 S0			                    ; Drive 6 goes backwards	[Rear Left Z]
M569 P7 S0				                ; Drive 7 goes backwards	[Right Z]
M350 Z16 I1	       		                ; Set 16x microstepping w/ interpolation
M92 Z1600	      		                ; Set axis steps per unit
M906 Z{1680 * 0.67} I30	                ; Set motor currents (mA)
M201 Z200                               ; Accelerations (mm/s^2)
M203 Z{12 * 60}                         ; Maximum speed
M566 Z{0.3 * 60}                        ; Maximum jerk speed

; Extruder
M584 E3                                 ; Set drive mapping extruder (E0) to drive 3
M569 P3 S0                              ; Drive 3 goes backwards
M350 E16 I1	        	                ; Set 16x microstepping w/ interpolation
M92 E830	        	                ; Set axis steps per unit
M906 E{1400 * 0.67} I30	                ; Set motor currents (mA)
M201 E5000            	                ; Accelerations (mm/s^2)
M203 E{120 * 60}                        ; Maximum speed
M566 E{3.5 * 60}              	        ; Maximum jerk speed

M84 S30                                 ; Set idle timeout


; Leadscrew locations
M671 X-21:-21:326 Y18:273:148 S7.5 
; Front left:   (-21,18)
; Rear Left:    (-21,273)
; Right         (326,148)

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
;M307 H0 R0.00 C431.9 D1.0 B0 S1.00 V0                  ; Set heating process parameters [H0:Bed, (B)angBang: Disabled, PWM:1.0]
M143 H0 S80                                             ; Maximum H0 (Bed) heater temperature (Conservative)
M140 H0							                        ; Define bed
M140 S-273 R-273                                        ; Standby and initial Temp for bed as "off" (-273 = "off")

; Print Hed Settings
M308 S1 P"spi.cs1" Y"rtd-max31865" A"Print-Head_Temp"
M950 H1 C"e0heat" T1                                    ; Create bed heater
M307 H1 A243.5 C96.5 D1.7 B0 S1.00 V24.2				; Set heating process parameters [H1:Print-Head, ACD, (B)angBang: Disabled, PWM:1.0]
;M307 H1 R243.5 C96.5 D1.7 B0 S1.00 V24.2				; Set heating process parameters [H1:Print-Head, (B)angBang: Disabled, PWM:1.0]
M143 H1 S300                                            ; Maximum H1 (Extruder) heater temperature
M563 P0 S"Print-Head" D0 H1 F0                          ; Define Tool
;M570 S360				                				; Print will be terminated if a heater fault is not reset within 360 seconds.

; Fans
; Part Cooling Fan
M950 F0 C"fan0" Q500                ; Create fan 0 on pin fan0 and set its frequency
M106 P0 S0 H-1 C"Part-Fan"          ; Set fan 0 name, value, PWM signal inversion and frequency. Thermostatic control is turned off
; Print Fan
M950 F1 C"fan1" Q500                ; Create fan 1 on pin fan1 and set its frequency
M106 P1 S0.75 H1 T45 C"Tool-Fan"    ; Set fan 1 name, value, PWM signal inversion and frequency. Thermostatic control is turned on

; Tool definitions
G10 P0 X0 Y0 Z0                     ; Set tool 0 axis offsets
G10 P0 R0 S0                        ; Set initial tool 0 active and standby temperatures to 0C
T0								    ; Select Tool 0

; IR Sensor
M558 P1 F120 H5 T7200 A5 S0.02 C"^zprobe.in"    ; Set Z probe type [P1:Mini-IR, (F)eedrate:120mm/min, Dive-(H)eight:5mm, (T)ravel:7200mm/min, 3 probes per point, 0.02mm tolerance]
G31 P500 X0 Y0 Z0							    ; Set Probe status, offsets
M557 X15:280 Y35:260 P3:3                       ; Define mesh grid

; BLTouch
;M950 S0 C"zprobe.mod"
;M558 P9 F120 H5 T7200 A5 S0.02 C"^zprobe.in"   ; Set Z probe type [P9:BLTouch, (F)eedrate:120mm/min, Dive-(H)eight:5mm, (T)ravel:7200mm/min, 3 probes per point, 0.02mm tolerance]
;G31 P25 X-2 Y33.5 Z2.851					    ; Set Z probe trigger value, offset and trigger height
;M557 X15:280 Y35:260 P3:3                      ; Define mesh grid

; Custom settings
M81												; ATX Power Off

;Virtual Sensor
M308 S2 P"duex.e2temp" Y"thermistor" A"Chamber-high" T100000 B3950 R4700 H0 L0
M308 S3 P"duex.e3temp" Y"thermistor" A"Chamber-low" T100000 B3950 R4700 H0 L0