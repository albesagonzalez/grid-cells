# grid-cells

## This is the code repository for a Practical Biomedical Modelling project, in the context of the Master of Science in Computational Neuroscience, Cognition and Artificial Intelligence at the University of Nottingham.

The project is coded in MATLAB with a CPP backend for some matrix operations. You can also find the final report submitted.

The folder CPP_files contains the original .cpp files and COMPILED_CPP contains the compiled functions generated with MEX (compiler.m)
The folder functions contains some MATLAB functions that the main scripts call.
The results folder is where tables, graphs, etc are saved by defaul, as well as the file with In Vivo path data is found. Also some precomputed initial states.

The grid_cells.m script can either load an initial state saved in a .mat file or create an initial (random) network state. There are severl parameters that can be changed as can be the type of network (Firing Rate / Spiking), the number of neurons and the boundaries (periodic / aperiodic). The network is by default coupled to the In Vivo processed file (generated with process_path.m), but can be easily decoupled by changing the velocity definition in network_evolver.m (functions)

results.m cals the different results functions in order to perform analysis on the simulated activity of the network (in time or in snapshots depending on the function)

The deformer.m file has some code for performing deformations in an initial state (dilations, rotations...)

Most of the code for movie_maker.m file (functions) can be found in Mathworks forum.

This was an academic project carried out during the month of February 2020.

