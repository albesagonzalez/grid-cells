function [t, S ] = spiking_network_evolver(network, experiment, m)

S_0 = network.S_0;
S_0=reshape(S_0, 1, network.N);
W = network.weights;
t_span =network.time; %time=0:network.time_step:network.time_stop;
alpha = [0.10315];
[t, S ]=Solver(t_span, S_0, m);

function v = V(t)
    v = [experiment.v_x(t), experiment.v_y(t)];
end

function prob=P(t,S_t)
    t_index=fix(t/network.time_step)+1;
    if rem(t_index ,500) == 0
        fprintf('t=%s s\n', round(t,2)) ;
    end
    %v =V(t_index); %V(t_index) ; %v(t); % v=v(t) or [0.5, 0] for init
    v=network.v;
    b = bias(network.A, network.preferences, alpha, v);
    S_t=reshape(S_t, network.N, 1);
    prob = max(W*S_t + b, 0);
end

function [spikes_count, spikes]= Spike_train(prob, m, spikes_count)
    % Poisson process
    X1=rand(1, network.N , m);
    rate=transpose(prob);% may be *dt (dt=delta_t/m);
    X2=X1<=rate;
    % Meet condition CV=1/sqrt(m); discarding all elements but m_th
    X3=sum(X2,3);
    spikes_count=spikes_count+X3;
    spikes=fix(spikes_count/m);
    spikes_count=spikes_count-m*spikes;
end

function y=f(x, h)
    tau=10*10^-3; % tau in s
    y=x*exp(-h/tau);
end

function S_tp1=Activation(spikes, delta_t, S_t)
    % If neuron spiked at t: S_i(t)=S_i(t)+1
    I1=find(spikes>0);
    S_t(I1)=S_t(I1)+1;
    % If neuron didn't spiked at t: dS_i(t)/dt=-S_i(t)/tau
    I2=find(spikes<1);
    S_t(I2)=f(S_t(I2) , delta_t);
    S_tp1=S_t;    
end

function [t, S]=Solver(t_span, S_0, m)
    spikes_count=zeros(1, network.N);
    S=[S_0];
    delta_t= network.time_step;
    %spikes_train=[];
    for t=t_span
        prob= P( t, S(end,:) ) ;   %maybe *delta_t
        [spikes_count , spikes] = Spike_train(prob, m , spikes_count );
        %spikes_train(end+1, :)=spikes;
        S(end+1, :)= Activation(spikes, delta_t, S(end,:) );
    end 
%save('spikes/spikes_20s_rat_CV1_periodic.mat', 'spikes_train', '-v7.3');
end

end