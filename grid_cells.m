addpath('Compiled_CPP')
addpath('Functions')


network.n = 128;
network.N = network.n^2;

% network.spiking = true;
% network.spiking_m = 8;
network.time_step = 0.0005;

network.periodic = true;
network.a_0 = 4;
network.R = 64;
network.r = 64;

network.lambda = 40;
%remember rerun for lambda 12.4
network.beta = 3/(network.lambda)^2;
network.gamma = 1.05*network.beta;
network.l = [1];

network.preferences = create_preferences(network);
network.weights = zeros(network.N, network.N);
network.weights = weights(network.weights, network.l, network.preferences);
network.weights = W_0(network.weights, network.beta, network.gamma);
network.A = A(network);

W = network.weights;

%network.weights = sparse(network.weights);

%save('Results/Constants/weights.mat', 'W', '-v7.3')

%connections = reshape(network.weights(1, :),[network.n,network.n]);
%surf(connections)


experiment = load('Results/Constants/processed_path.mat');
experiment.duration = 5;
end_index = find(abs(round(experiment.pos_timeStamps, 2) - round(experiment.duration, 2)) < 0.001);
experiment.t_span = 1000*experiment.pos_timeStamps(1:end_index);

%network.S_0 = create_initial(network);
%network.S_0 = load('Results/Constants/initial_S.mat').S_0;
%network.S_0 = load('Results/Tables/rotated_10.mat').S_0;
network.S_0 = load('Results/Tables/homothety_1_3.mat').S_ap;

network.S = [];
network.t = [];

[network.t, network.S] = network_evolver(network, experiment);
%[network.t, network.S] = spiking_network_evolver(network, experiment, 8);

S = network.S;
t = network.t;
% 
% %S_0 = network.S(end, :);
% save('initial_S.mat', 'S_0')
save('Results/Tables/ratio_1_3.mat', 'S', 't', '-v7.3')
% 
% disp('3')
% 

%S = load('Results/Tables/trial_spiking.mat').S;
%size(S)
% Z = reshape(network.S(end, :),[network.n,network.n]);
%  
% figure(1)
% surf(Z)




function W_0 = W_0(x, beta, gamma)
a = 1;
W_0 = a.*exp(-gamma.*x) - exp(-beta.*x);
end

function A = A(network)
N = network.N;
periodic = network.periodic;
if periodic
    A = zeros(N, 1) + 1;
else
    r = network.r;
    R = network.R;
    a_0 = network.a_0;
    arguments = [N, a_0, R, r];
    A = a_envelope(arguments);

end
end


function v = velocities(network)
time_windows = (network.tfinal - network.tstart)/network.time_step;
v = zeros(1, time_windows);
end


function S_0 = create_initial(network)
    N = network.N;
    S_0 = 0.1*rand(N, 1);
end

function p = create_preferences(network)
    n = network.n;
    N = network.N;
    d1 = [0, 1, 0, -1];
    p1 = repmat(d1, 1, n/2);
    d2 = [1, 0, -1, 0];
    p2 = repmat(d2, 1, n/2);
    d = [p1, p2];
    p = repmat(d, 1, n/2);
end