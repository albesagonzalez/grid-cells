function center_positions = flow_of_network(filename)

S = load(filename).S;


N = length(S(1,:));

times = length(S(:, 1));

n = sqrt(N);

center_positions = [];

cell_center = [66, 66];

for t = 1:times
    S_t = S(t, :);
    window_center = get_center(S_t, cell_center, n, N);
    center_positions = [center_positions; window_center];
    cell_center = window_center;
end



function window_center = get_center(S_t, window_center, n, N)
    window_radius = 7;
    window_width = 15;
    Z = reshape(S_t,[n, n]);
    i_span = (window_center(1) - window_radius):1:(window_center(1) + window_radius);
    j_span = (window_center(2) - window_radius):1:(window_center(2) + window_radius);
    window = Z(i_span, j_span);
    S_window = reshape(window,[window_width^2, 1]);
    [max, position] = maxk(S_window, 1);
    center = coordinates(position, window_width);
    window_center = [window_center(1) - window_radius + center(1) - 1, window_center(2) - window_radius + center(2) - 1];
end

function coordinates = coordinates(position, window_width)
[j, i] = quorem(sym(position), sym(window_width));
coordinates = [i, j + 1];
end

end