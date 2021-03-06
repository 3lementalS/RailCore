G91                 		; Set to Relative Positioning

G1 H2 Z5 F1000      		; Move Z down 5mm @1000mm/min

G90                 		; Set to Absolute Positioning
G1 X149.50 Y114.00 F2400  	; Move to the center of the bed @2400mm/min
G30                 		; Single Z-Probe