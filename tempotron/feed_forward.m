function [V, tmax, vmax] = feed_forward(inspikes, W, T)

%model parametrs

tau = 15;
taus = tau/4;

Np = 1;    %number of patterns
Ns = length(inspikes);    %number of input synapses

V0 = 2.12;

%PSP kernel
K = @(t,ti) (t>ti)*(V0*(exp(-(t-ti)/tau) - exp(-(t-ti)/taus)));


V = zeros(1, Np*T);

tmax = 1;
vmax = -9999;

for t = 1:Np*T
    sums = zeros(1, Ns);
    for i = 1:Ns
        sums(i) = K(t, inspikes(i,1));
    end

    V(t) = (W * sums');

    if V(t) > vmax
        vmax = V(t);
        tmax = t;
    end
end
