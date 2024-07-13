#pragma config(Sensor, S4,     lightSensor,    sensorNone)
#pragma config(Motor,  motorA,          singleMotor,   tmotorEV3_Large, PIDControl, encoder)

const int DEFAULT_SPEED = 10;

task main()
{
	// Runs the motor at default speed
	setMotorSpeed(singleMotor, DEFAULT_SPEED);

	// Resets the datalog
	datalogFlush();
	datalogClose();

	// Terminates the program when datalog can not be opened with the given parameters
	if (!datalogOpen(1, 1, false)) {
		displayCenteredBigTextLine(1, "Unable to open datalog");
		return;
	}

	// Gets the color reflection and adds it to the datalog for ~0.75 secs to measure ~18mm barcode
	for (int i = 0; i < 75; i++) {
		int reflection = getColorReflected(lightSensor);
		displayCenteredBigTextLine(3, "%d", reflection);
		datalogAddShort(0, reflection);
		sleep(10);
	}

	// Closes the datalog
	datalogClose();
}
