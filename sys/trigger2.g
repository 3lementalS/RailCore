M18; Disable Steppers
M104 S0; Set Hot-end to 0C (off)
M140 S0; Set bed to 0C (off)
M291 P"Shutdown request active. Waiting for extruder to cool to 45 deg." T5
M109 R45; wait until extruder cools to 45 deg 
M81 S1 ; Turn off printer once cooled down
M42 P1 S1 ; Turn Off Duet Power (inverted logic)