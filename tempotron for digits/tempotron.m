[V, ptmax, pvmax, ntmax, nvmax] = forward_pass(pinput, ninput)

%model parametrs

tau = 15;
taus = tau/4;

T = 500;    %ms

Np = 10;    %number of patterns
Ns = 10;    %number of input synapses

V0 = 2.12;

Vrest = 0;
Vthr = 1;

%PSP kernel
K = @(t,ti) (V0*(exp(-(t-ti)/tau) - exp(-(t-ti)/taus)));


V = zeros(2, Np*T);

ptmax = 1;
pvmax = -9999;
ntmax = 1;
nvmax = -9999;

for t = 1:Np*T
    psum = zeros(1, Ns);
    nsum = zeros(1, Ns);
    for ti = 1:t
        for i = 1:Ns
            if pinputs(i,ti) == 1
                psum(i) = psum(i) + K(t, ti);
            end
            if ninputs(i,ti) == 1
                nsum(i) = nsum(i) + K(t, ti);
            end
        end
    end
    V(1,t) = W*psum';
    V(2,t) = W*nsum';
    if V(1,t) > pvmax
        pvmax = V(1,t);
        ptmax = t;
    end
    if V(2,t) > nvmax
        nvmax = V(2,t);
        ntmax = t;
    end
end
