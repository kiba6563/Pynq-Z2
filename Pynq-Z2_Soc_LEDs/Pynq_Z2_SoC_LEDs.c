/******************************************************************************
*
* Engineer: Kishore Bachu
* Date: 12th March 2023
* Program: LED Toggling on Pynq-Z2 FPGA board
* UART Baud Rate: 115200
*
******************************************************************************/

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xgpio.h"
#include "xparameters.h"

XGpio led_4bits;
XGpio rgb_led;
XGpio sw_2bits;

//Function to initialize GPIOs
void init_gpio()
{
	int status1;
	int status2;
	int status3;

	status1 = XGpio_Initialize(&sw_2bits, XPAR_AXI_GPIO_0_DEVICE_ID);
	status2 = XGpio_Initialize(&led_4bits, XPAR_AXI_GPIO_1_DEVICE_ID);
	status3 = XGpio_Initialize(&rgb_led, XPAR_AXI_GPIO_0_DEVICE_ID);

	if ((status1 && status2 && status3) == XST_SUCCESS)
		xil_printf("GPIO initialization is SUCCESS \n");
	else
		xil_printf("GPIO initialization FAILED \n");
}

int main()
{
	u32 swInput;	//SW input

	//Initialize platform
    init_platform();

    //Initialize GPIO function
    init_gpio();

    //Data Direction for led_4bits. DirectionMask = 0 (output)
    XGpio_SetDataDirection(&led_4bits, 1, 0);

    //Data Direction for sw_2bits. Channel = 1. DirectionMask = 1 (input)
    XGpio_SetDataDirection(&sw_2bits, 1, 1);

    //Data Direction for led_4bits. Channel = 2. DirectionMask = 0 (output)
    XGpio_SetDataDirection(&rgb_led, 2, 0);

   	while(1)
   	{
   		swInput = XGpio_DiscreteRead(&sw_2bits, 1);		//Read Switches' value

   	   	xil_printf("Switch Value: %0d \n", swInput);

		if (swInput == 0x3)		//Toggle LEDs
		{
			XGpio_DiscreteWrite(&rgb_led, 2, 0x24);		//Turn ON RED
			XGpio_DiscreteWrite(&led_4bits, 1, 0x07);	//Turn ON LD0-LD2
			sleep(1);	//Wait for 1sec

			XGpio_DiscreteWrite(&rgb_led, 2, 0x12);		//Turn ON GREEN
			XGpio_DiscreteWrite(&led_4bits, 1, 0x0e);	//Turn ON LD1-LD3
			sleep(1);	//Wait for 1sec

			XGpio_DiscreteWrite(&rgb_led, 2, 0x09);		//Turn ON BLUE
			XGpio_DiscreteWrite(&led_4bits, 1, 0x06);	//Turn ON LD1-LD2
			sleep(1);	//Wait for 1sec

			XGpio_DiscreteWrite(&rgb_led, 2, 0x3F);		//Turn ON RED+GREEN+BLUE
			XGpio_DiscreteWrite(&led_4bits, 1, 0x0c);	//Turn ON LD2-LD3
			sleep(1);	//Wait for 1sec
		}
		else			//Turn OFF toggle
		{
			XGpio_DiscreteWrite(&led_4bits, 1, 0x00);	//Turn OFF LED0-LD3
			XGpio_DiscreteWrite(&rgb_led, 2, 0x00);		//Turn OFF RGB LEDs
			sleep(1);	//Wait for 1sec
		}
   	}
    cleanup_platform();
    return 0;
}
