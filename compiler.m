addpath('CPP_files')

% mex -outdir Compiled_CPP CPP_files/a_envelope.cpp
% mex -outdir Compiled_CPP CPP_files/bias.cpp
% mex -outdir Compiled_CPP CPP_files/process_positions.cpp
 mex -outdir Compiled_CPP CPP_files/smooth.cpp
% mex -outdir Compiled_CPP CPP_files/weights.cpp

mex -outdir Compiled_CPP CPP_files/lattice_distance.cpp