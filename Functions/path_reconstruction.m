function path_reconstruction(filename, scale_factor)

decoded_positions = flow_of_network(filename)

exp = load('processed_path.mat');
%plot(center_positions(:, 2), center_positions(:, 1))


real_x = exp.pos_x(1:744);
real_y = exp.pos_y(1:744);


decoded_x = scale_factor*decoded_positions(:, 2);
decoded_y = scale_factor*decoded_positions(:, 1);

delta_x = decoded_x(1) - real_x(1);
delta_y = decoded_y(1) - real_y(1);



decoded_x = decoded_x - delta_x + 7;
decoded_y = decoded_y - delta_y;

%diff_x = abs(decoded_x - real_x);
%iff_y = abs(decoded_y - real_y);

%drift = (diff_x.^2 + diff_y.^2).^(1/2);


plot(real_x, real_y, decoded_x, decoded_y)
%plot(exp.pos_timeStamps(1:244), drift)


end

