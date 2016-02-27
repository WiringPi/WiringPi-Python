// wiringPi modes

%constant int WPI_MODE_PINS = 0;
%constant int WPI_MODE_GPIO = 1;
%constant int WPI_MODE_GPIO_SYS = 2;
%constant int WPI_MODE_PHYS = 3;
%constant int WPI_MODE_PIFACE = 4;
%constant int WPI_MODE_UNINITIALISED = -1;

// Pin modes

%constant int INPUT = 0;
%constant int OUTPUT = 1;
%constant int PWM_OUTPUT = 2;
%constant int GPIO_CLOCK = 3;
%constant int SOFT_PWM_OUTPUT = 4;
%constant int SOFT_TONE_OUTPUT = 5;
%constant int PWM_TONE_OUTPUT = 6;

%constant int LOW = 0;
%constant int HIGH = 1;

// Pull up/down/none

%constant int PUD_OFF = 0;
%constant int PUD_DOWN = 1;
%constant int PUD_UP = 2;

// PWM

%constant int PWM_MODE_MS = 0;
%constant int PWM_MODE_BAL = 1;

// Interrupt levels

%constant int INT_EDGE_SETUP = 0;
%constant int INT_EDGE_FALLING = 1;
%constant int INT_EDGE_RISING = 2;
%constant int INT_EDGE_BOTH = 3;
