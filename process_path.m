
% mex process_positions.cpp

addpath('Compiled_CPP')

S = load('Results/Hafting_Fig2c_Trial1.mat');

pos_x = S.pos_x;
pos_y = S.pos_y;
pos_timeStamps = S.pos_timeStamps;

velocities = process_positions(pos_timeStamps, pos_x, pos_y);

v_x = velocities(:, 1);
v_y = velocities(:, 2);

good_ind = find(isnan(v_x) == 0);
 
pos_x = pos_x(good_ind);
pos_y = pos_y(good_ind);
pos_timeStamps = pos_timeStamps(good_ind);
v_x = v_x(good_ind);
v_y = v_y(good_ind);

firing_timeStamps = S.rat11015_t7c3_timeStamps;

num_firings = size(firing_timeStamps);
num_firings = num_firings(1);

floor_ = floor(firing_timeStamps);

firing_timeStamps = floor_ + ceil((firing_timeStamps - floor_)/0.02) * 0.02;


firing_x = [];
firing_y = [];

for i = 1:num_firings
    firing_index = find(abs(round(pos_timeStamps, 2) - round(firing_timeStamps(i), 2)) < 0.001);
    try
        firing_x(end + 1) = pos_x(firing_index);
        firing_y(end + 1) = pos_y(firing_index);     
    catch
    end
end


%save('Results/Constants/processed_path.mat', 'pos_timeStamps', 'pos_x', 'pos_y', 'v_x', 'v_y', 'firing_x', 'firing_y')

% pp = load('processed_path.mat');
% 
% pos_x = pp.pos_x(1:1500);
% pos_y = pp.pos_y(1:1500);
% v_x = pp.v_x(1:1500);
% v_y = pp.v_y(1:1500);
% 
% 
% figure(1) 
% quiver(pos_x, pos_y, v_x, v_y, 0.1)


% figure(2) 
% pos_x = pp.pos_x(1:15000);
% pos_y = pp.pos_y(1:15000);
% 
% plot(pos_x, pos_y, 'b')
% hold on
% 
% firing_X = pp.firing_x;
% firing_Y = pp.firing_y;
% 
% scatter(firing_X, firing_Y, 'r', '*')