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

lambda = 0.1;

while (pvmax < Vthr || nvmax > Vthr)

while (pvmax < Vthr)
    dW = zeros(1, Ns);
    for ti = 1:(ptmax-1)
        for i = 1:Ns
            if pinputs(i,ti) == 1
                dW(i) = dW(i) + K(ptmax, ti);
            end
        end
    end

    dW = dW * lambda;
    W = W + dW;
    [V, ptmax, pvmax, ntmax, nvmax] = forward_pass(pinputs, ninputs, W);
    pvmax
    nvmax
    
end

while (nvmax > Vthr)
    dW = zeros(1, Ns);
    for ti = 1:(ntmax-1)
        for i = 1:Ns
            if ninputs(i,ti) == 1
                dW(i) = dW(i) + K(ntmax, ti);
            end
        end
    end
    
    dW = dW * lambda;
    W = W - dW;
    [V, ptmax, pvmax, ntmax, nvmax] = forward_pass(pinputs, ninputs, W);
    pvmax
    nvmax
end

end
