# SingleCopter-OpenSCAD
Single Copter OpenSCAD Design

### BOM
- 4x GridFins
- 1x Outside Frame and Central Mount
- 2x Carbon Fibre rods
- 1x Contra Rotaing Motor i.e. https://hobbyking.com/en_us/contra-rotating-bl-system-375w.html?___store=en_us
- 2x 20amp esc
- 2x Blades for motor 10" x 04" or 10" x 05"
- 1x 3 cell battery
- 1x Flight Controller Ardupilot (pixRacer) gps if needed
- 4x Servos i.e. https://hobbyking.com/en_us/turnigytm-tgy-d56mg-coreless-ds-mg-hv-servo-1-2kg-0-10sec-5-6g.html?___store=en_us 
- 1x pdb to supply servos depends on servo voltage. 
- 1x battery 


### SETUP
https://github.com/mirkix/BBBMINI/blob/master/doc/software/software.md
http://ardupilot.org/copter/docs/singlecopter-and-coaxcopter.html


Impliment this for debugging https://github.com/dogmaphobic/mavesp8266


TODO:
BBBMini Setup:

Get Servo Range
SERVO1_MIN: the forward flap/servo’s lowest PWM value before it hits its physical limits.
SERVO1_MAX: the forward flap/servo’s highest PWM value before it hits its physical limits.
SERVO1_TRIM: the forward flap/servo’s PWM value close to what is required to keep the vehicle from spinning.
SERVO1_REVERSED: the forward flap/servo’s reverse setting. 0 = servo moves in default direction, 1 to reverse direction of movement.
