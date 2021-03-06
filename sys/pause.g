M83			    ; Set extruder to relative mode
G1 E-2 F2500    ; Retract 2mm
G91			    ; Set to Relative Positioning
G1 Z5 F5000	    ; Lower bed down by 5mm
G90			    ; Set to Absolute Positioning
G1 X0 Y0 F5000  ; Move head out of the way of the print