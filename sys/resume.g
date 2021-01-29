G1 R1 X0 Y0 Z2 F5000	; move to 2mm above resume point
G1 R1 X0 Y0			    ; lower nozzle to resume point
M83				        ; relative extruder moves
G1 E2 F2500		        ; undo the retraction