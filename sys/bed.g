M561                            ; clear any existing bed transform
G1 Z5 S2                        ; Move bed down 5mm
G30 P0 X15 Y45 Z-99999          ; Probe the bed at X15 Y45 with height error as point 0
G30 P1 X15 Y275 Z-99999         ; Probe the bed at X15 Y275 with height error as point 1
G30 P2 X275 Y275 Z-99999        ; Probe the bed at X275 Y275 with height error as point 2
G30 P3 X275 Y45 Z-99999 S3      ; Probe the bed at X275 Y45 with height error as point 3 and calculate 3-point compensation

G1 X0 Y0 F5000                  ; move the head to the corner (optional)

