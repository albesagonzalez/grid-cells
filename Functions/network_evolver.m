function [t, S] = network_evolver(network, experiment)

global exp

exp = experiment;

S_0 = network.S_0;
W = network.weights;

t_span = experiment.t_span;


alpha = [0.10315];


opts = odeset('MaxStep', 50);
%[t, S] = ode45(@LIF, t_span, S_0, opts);


[t, S] = ode23(@LIF, t_span, S_0, opts);





function RHS = LIF(t,S)
    if rem(fix(t) , 50) == 0
        disp(t)
    end
    %v = v_of(t);
    v = [0, 0.3];
    b = bias(network.A, network.preferences, alpha, v);
    %try to feed output matrix directly instead of creating in c script
    Z = max(W*S + b, 0);
    RHS = (0.1).*(-S + Z);
end

function prob= spiking_LIF(t,S_t)
    t_index=fix(t/0.0005)+1;
    if rem(t_index ,500) == 0
        fprintf('t=%s s\n', round(t,2)) ;
    end
    %v =V(t_index); %V(t_index) ; %v(t); % v=v(t) or [0.5, 0] for init
    v=[0.2 ,0.2 ];
    b = bias(network.A, network.preferences, alpha, v);
    S_t=reshape(S_t, network.N, 1);
    prob = max(W*S_t + b, 0);
end


function v = v_of(t)
    v_index = discretize(round(t/1000, 2), exp.pos_timeStamps);
    v = [exp.v_x(v_index), exp.v_y(v_index)];
end


end