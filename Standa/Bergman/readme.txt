Jan Bergman, 2024-07-03:

To move the translation stages using Matlab:

1. Connect the stages to the 8SMC5 controller
	a. Please note that the different stages have different settings (max speed, movement per step
	   etc.) Make sure that they are connected to the correct axes or change the settings (XILab
	   or Matlab)

2. Connect the PC to the controller via USB
	a. Note that the USB-As on the controller are for daisy chaining multiple controllers together.
	   Use the USB-B Port.

3. Power up the controller using the KPPX-4P connector and a 12 V supply.
	a. The servos are rated for 12 V, which should thus not be exceeded even though the controller
	   handles higher voltages.

4. Run the RunXYStages.m code.
	a. Many errors can occur, good luck.
	b. One thing to check is if the settings of the controller are correct. I have uploaded correct
	   settings to the flash memory of the controller on 2024-07-03. However, if the settings have 
	   been lost or changed, they should be manually changed back.
		1. For this, follow the steps in ../standa/StandaOhjeet.txt
		2. Set the max speed to 0.500 for the stepper motors. The speed in the instructed files 
		   is too fast for our motors. You have to do this manually.
		3. Alternatively, you could change all the settings in Matlab, given that you can 
		   connect to the device but not move it (see GetSettings.m [WIP] for some hints on 
		   how to do this.
