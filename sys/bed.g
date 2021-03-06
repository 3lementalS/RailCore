;M561                            ; Clear any existing bed transform
;G1 Z5 H2                        ; Move bed down 5mm
;G30 P0 X24.4 Y35 Z-99999 		; Probe the bed at X15 Y45 (Point 0)
;G30 P1 X24.4 Y260 Z-99999 		; Probe the bed at X15 Y275 (Point 1)
;G30 P2 X280 Y147.50 Z-99999 S3	; Probe the bed at X275 Y150 (Point 2), calculate 3-point calibration

;G1 X149.5 Y114 F5000 			; Move the head to the corner
;G30								; Single Z-Probe

M561                            ; Clear any existing bed transform
G1 Z5 H2                        ; Move bed down 5mm
G30 P0 X15 Y35 Z-99999 			; Probe the bed at X15 Y45 (Point 0)
G30 P1 X15 Y260 Z-99999 		; Probe the bed at X15 Y275 (Point 1)
G30 P2 X280 Y260 Z-99999		; Probe the bed at X275 Y150 (Point 2)
G30 P3 X280 Y35 Z-99999 S3		; Probe the bed at X275 Y150 (Point 3), calculate 3-point calibration

G28 Z