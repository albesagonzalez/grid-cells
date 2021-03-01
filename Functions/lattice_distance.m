
function lambda = lattice_distance(filename)
%% this function returns the average distance between maximums in a network actvity snapshot

addpath('Compiled_CPP')
%%
%first load the output of network and select your timeframe
S = load(filename).S;
N = length(S(end,:));
n = sqrt(N);
S_0 = S(end, :);
times = length(S(:, 1));


%% now get the 500 maximum positions and smooth them into bumps


maximums = 500;
[max, position] = maxk(S_0, maximums);
max_positions = coordinates(position, n);
X = max_positions(1, :);
Y = max_positions(2, :);
X = cast(X, 'double');
Y = cast(Y, 'double');
[av_x, av_y] = smooth(X, Y);
positions_matrix = [av_x'; av_y']';
unique_positions = unique(round(positions_matrix), 'rows');
max_x = cast(unique_positions(:, 1), 'double');
max_y = cast(unique_positions(:, 2), 'double');
scatter(max_x, max_y);


%% compute average distance between smoothed maximums

num_maximums = length(max_x);

%in order to do this we need to define an approximate radius to look for neighbours.
%we obtain such approximation by divding the lateral longitud by the sqrt of the number of
%maximums and magnifiying by a factor in the middle of 1 and sqrt(3) i.e.
%1.4

max_per_longitude = sqrt(num_maximums);
lattice_bound = [1.4*n/max_per_longitude];


lambda = lattice_distance(max_x, max_y, lattice_bound);



%% functions

function coordinates = coordinates(position, n)
[j, i] = quorem(sym(position), sym(n));
coordinates = [j + 1; i];
end


function pos_lambda = lattice_coordinates(positions, lambda)
vector_y = [cos(pi/3 + 0.05), sin(pi/3 + 0.05)];
y_lattice = positions'*vector_y';
pos_lambda = cast(mod(y_lattice, lambda), 'double')

end

end

