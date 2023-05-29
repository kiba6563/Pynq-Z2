# RGB LEDs
A VHDL project code to toggle RGB LEDs on Pynq-Z2 board.

## Structure
Top module: rgb_led_pwm.vhd
Child modules: slow_clock.vhd, led4_pwm.vhd, led5_pwm.vhd

<i><b>slow_clock.vhd:</b></i> Generates a slow clock of 1Hz with 50% duty cycle from an on-board 125MHz. 
<br />
<i><b>led4_pwm.vhd:</b></i> Toggles RGB LED4 
<br />
<i><b>led5_pwm.vhd:</b></i> Toggles RGB LED5
<br />
<i><b>rgb_led_pwm.xdc:</b></i> Physical constraints
<br />

## Tools
<li>Vivado 2022.2</li>
<li>Pynq-Z2 FPGA board</li>

## RGB LEDs Test
![Media_230313_151828](https://user-images.githubusercontent.com/127403893/224666514-44ed5bf7-3eeb-4822-b52c-970aca8705a4.gif)
