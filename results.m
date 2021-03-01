%% this script calls the different functions defined in order to perform analysis in the results
% obtained in grid_cells.m

%first choose a filename

addpath('Functions')

filename = 'Results/Tables/5_s_E.mat';

%% path_reconstruction
path_reconstruction(filename)

%% SN analysis
SN_analysis(filename)

%% movie maker generates a movie with the evolution of network activity (most of code is copy-pasted
%from an online script)
movie_maker(filename)

%% lattice_distance returns the average distance of the final activity of the network
lattice_distance(filename)

%% orientation returns the main 3 directions of a network at a particular time
orientation(filename, time)
