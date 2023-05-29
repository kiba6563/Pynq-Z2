# https://support.xilinx.com/s/article/64452?language=en_US
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets LED4_EN_IBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets LED5_EN_IBUF]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets BTN3_B_IBUF]

# SYS_CLK             
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports SYS_CLK]

# RESET on BTN0 
set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports SYS_RESET]

# On-board RGB LED4
set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports LED4_R]
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports LED4_G]
set_property -dict {PACKAGE_PIN L15 IOSTANDARD LVCMOS33} [get_ports LED4_B]

# On-board RGB LED5
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports LED5_R]
set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS33} [get_ports LED5_G]
set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports LED5_B]

# On-board Slide Switches
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports LED4_EN]
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33} [get_ports LED5_EN]