the VHDL folder contains:
aux_package - is the aux_package of our DUT
top - our top design of the DUT
Digital_System - is the verification test-bench we created
Digital_System_top - envelopes Digital_System to increase fan-out and fan-in
	of the inputs and outputs of Digital_System component.
PLL - is the PLL vhdl file we had imported from Quartus to implement inside our
	Digital_System test-bench.
segment - is a component we created to help us make use of the 7-segment output.