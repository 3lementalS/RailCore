; Configuration file for My Printer
; Communication and general
M111 S0                             	; Debug off
M550 P"RailCore"				        ; Machine name and Netbios name (can be anything you like)
M551 P"GGamer1894@!"                    ; Machine password (used for FTP)
;*** Wifi Networking
M552 S1								    ; Enable WiFi
M555 P2                           	    ; Set compatibility S2:Marlin
M575 P1 B57600 S1					    ; Set serial comms parameters [Channel (P)1, (B)aud Rate:57600, (S)1:PanelDue mode, checksum required]

G21                                 	; Set Units to Millimeters
G90                                		; Set to Absolute Positioning
M83                                 	; Set extruder to relative mode
M667 S1								    ; Select CoreXY

;XY Axis
M584 X0 Y1                              ; Set drive mapping X to drive 0, Y to drive 1
M569 P0 S0                              ; Drive 0 goes forwards
M569 P1 S0                              ; Drive 1 goes forwards
M350 X16 Y16 I1	                        ; Set 16x microstepping w/ interpolation
M92 X200 Y200	                        ; Set axis steps per unit, X/Y may be more around 201.5 for accuracy 
;Kinematics
M906 X1000 Y1000 I60	                ; Set motor currents (mA)
M201 X3000 Y3000                        ; Accelerations (mm/s^2)
M203 X24000 Y24000                      ; Maximum speeds (mm/min)
M566 X1000 Y1000                        ; Maximum jerk speeds mm/minute

;Z Axis
M584 Z5:6:7                             ; Set drive mapping Z to drive 5, 6, and 7 for DueX5
M569 P5 S0							    ; Drive 5 goes backwards	Front Left Z
M569 P6 S0							    ; Drive 6 goes backwards	Rear Left Z
M569 P7 S0							    ; Drive 7 goes backwards	Right Z
M350 Z16 I1	                            ; Set 16x microstepping w/ interpolation
M92 Z1600 E837	                        ; Set axis steps per unit
;Kinematics
M906 Z1000 I60	                        ; Set motor currents (mA)
M201 Z20                                ; Accelerations (mm/s^2)
M203 Z900                               ; Maximum speeds (mm/min)
M566 Z30                                ; Maximum jerk speeds mm/minute


;Extruder
M584 E3                                 ; Set drive mapping extruder (E0) to drive 3
M569 P3 S1                              ; Drive 3 goes forwards
M350 E16 I1	                            ; Set 16x microstepping w/ interpolation
M92 E837	                            ; Set axis steps per unit
;Kinematics
M906 E700 I60	                        ; Set motor currents (mA)
M201 E1000                              ; Accelerations (mm/s^2)
M203 E3600                              ; Maximum speeds (mm/min)
M566 E20                                ; Maximum jerk speeds mm/minute


;Leadscrew locations
M671 X-10:-10:333  Y22.5:277.5:150 S7.5 ;Front left, Rear Left, Right  S7.5 is the max correction - measure your own offsets, to the bolt for the yoke of each leadscrew

;Endstops
M574 X1 Y1 Z0 S1		                ; Set endstop position [XY: Low-End (1), Active-high (S1)]

M208 X290 Y290 Z280 S0                  ; Set axis max travel
M208 X0 Y0 Z-0.5 S1                     ; Set axis min travel [Adjust to make X=0 and Y=0 the edges of the bed]

;Print Hed Settings
M305 P1 S"Print-Head" X200	            ; Set temperature sensor parameters [PT100]
M307 H1 A270.7 C90.4 D6.7 B0 S1.0 V24.0 ; Set heating process parameters [H1:Print-Head, ACD, (B)angBang: Disabled, PWM:1.0]
;M570 S360				                ; Set output on extrude
M143 S285                               ; Maximum heater temperature

;Heated Bed Settings
M305 P0 S"Top-Bed_Temp" T100000 B3950 R4700     ; Set temperature sensor parameters [Groove thermistor]
M307 H0 A240.3 C608.7 D8.2 B0 S1.00 V0          ; Set heating process parameters [H0:Bed, ACD, (B)angBang: Disabled, PWM:1.0]

; Fans
; Print Fan
; Part Cooling Fan
	
; Tool definitions
M563 P0 D0 H1                       	; Define tool 0
G10 P0 S0 R0                        	; Set tool 0 operating and standby temperatures
T0					; select first hot end

; Z probe and compensation definition
;*** If you have a switch instead of an IR probe, change P1 to P4 in the following M558 command
M558 P1 X0 Y0 Z1			; Z probe is an IR probe and is not used for homing any axes
G31 X0 Y30 Z2.00 P500			; Set the zprobe height and threshold (put your own values here) 

;BLTouch - leave commented out if using a IR Probe
;M307 H3 A-1 C-1 D-1
;M558 P9 X0 Y0 Z1 H5 F50 T6000 A5 S0.02  
;G31 X2 Y42 Z2.65 P25 ; Customize your offsets appropriately.