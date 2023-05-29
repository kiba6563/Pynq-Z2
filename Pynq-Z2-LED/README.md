# Pynq-Z2-LED
VHDL code to blink LEDs on the PYNQ-Z2 FPGA board. Push button switches control the direction of LED toggling in LEFT and RIGHT directions.

## Structure
Top module: leds_toggle_top.vhd
Child modules: slow_clock.vhd, push_button.vhd, led_toggle.vhd

<i><b>slow_clock.vhd:</b></i> Generates a slow clock of 1Hz with 50% duty cycle from an on-board 125MHz. 
<br />
<i><b>push_button.vhd:</b></i> Latches the push button value.
<br />
<i><b>led_toggle.vhd:</b></i> Toggles on-board 4-LEDs in LEFT or RIGHT directions set by the on-board push buttons BTN1 and BTN2 respectively
<br />
<i><b>led_toggle_tb.vhd:</b></i> Test bench for simulation
<br />
<i><b>leds_toggle.xdc:</b></i> Physical constraints
<br />

## Tools
Vivado 2022.2
<br />
Pynq-Z2 FPGA board

## Simulation
![WaveForm](https://user-images.githubusercontent.com/127403893/224462408-38ab37dd-d556-4b90-98b9-d5bd7e6befdc.JPG)

## LEDs Test
![gif_1678434190289](https://user-images.githubusercontent.com/127403893/224254519-bb5f76c4-de98-47c5-9464-0eb0dd9b3021.gif)
<br />
Fig: LED toggling in LEFT
<br />
<br />
![gif_1678435109398](https://user-images.githubusercontent.com/127403893/224257826-68b08684-5e0f-471a-a691-7ae5fafcc718.gif)
<br />
Fig: LED toggling in RIGHT
<br />
