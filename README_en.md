# Special Measure
## Usage Instructions
**Note: Always run files from the folder where they are located.**
### Running the Program
To use it on a computer that already has the rack properly configured (the `rack.mat` file exists), simply open the `run.m` file in MATLAB and execute it. (Ensure that the Library folder, along with all its subfolders, is included in the MATLAB path.)
### Configuring a Rack
The `generate_instruments.m` file creates a copy of the instruments included in the Library/instruments folder. This process also adds a constructor for communication via VISA, using the address specified in constructor.args.
You must execute this file to generate the local copies of the `smint_INSTRUMENT.mat` files.
After generating the instruments, run `configure_rack.m` to create the base rack file with those instruments.

This procedure of generating the instruments and configuring the rack usually only needs to be done when adding a new instrument or if, for some reason, the GPIB ports change.

---

A copy of the original SpecialMeasure code is available in the [original branch](https://github.com/LabNano/special-measure/tree/original).
