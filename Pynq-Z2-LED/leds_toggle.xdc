# https://support.xilinx.com/s/article/64452?language=en_US
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets LED_EN_L_IBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets LED_EN_R_IBUF]

# SYS_CLK
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports SYS_CLK]

# RESET on BTN0
set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports SYS_RESET]

# On-board leds
set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports {LED[0]}]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {LED[1]}]
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports {LED[2]}]
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {LED[3]}]

# On-board Buttons
set_property -dict {PACKAGE_PIN D20 IOSTANDARD LVCMOS33} [get_ports LED_EN_L] #BTN1
set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVCMOS33} [get_ports LED_EN_R] #BTN2  

set_property IOSTANDARD LVCMOS33 [get_ports LED_EN_L]   
set_property IOSTANDARD LVCMOS33 [get_ports LED_EN_R]
set_property PACKAGE_PIN D20 [get_ports LED_EN_L]   
set_property PACKAGE_PIN L20 [get_ports LED_EN_R]   