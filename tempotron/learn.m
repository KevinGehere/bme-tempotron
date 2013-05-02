%model parametrs

tau = 15;
taus = tau/4;

T = 255;    %ms

Np = 1;    %number of patterns
Ns = 784;    %number of input synapses

V0 = 2.12;

Vrest = 0;
Vthr = 1;

%PSP kernel
K = @(t,ti) (V0*(exp(-(t-ti)/tau) - exp(-(t-ti)/taus)));

lambda = 0.002;

%inspikes = round((500-1) * rand(Ns, Np) + 1);
W = rands(2,Ns) ./ 100;

for epoch = 1:10
epoch
for ii = 1:3
for jj = 2:2
ii
    
inspikes = images(:,inds(ii,jj));
pidx = jj;
nidx = [1:pidx-1 pidx+1:2];

[V, tmax, vmax] = feed_forward(inspikes, W(pidx,:), T);
pidx
vmax
if (vmax < Vthr)
    dW = zeros(1, Ns);
    for ti = 1:(tmax-1)
        for i = 1:Ns
            dW(i) = dW(i) + K(tmax, ti);
        end
    end

    dW = dW * lambda;
    W(pidx,:) = W(pidx,:) + dW;
end

for kk = 1:length(nidx)
    ni = nidx(kk);
    [V, tmax, vmax] = feed_forward(inspikes, W(ni,:), T);
    ni
    vmax
    if (vmax >= Vthr)
        dW = zeros(1, Ns);
        for ti = 1:(tmax-1)
            for i = 1:Ns
                dW(i) = dW(i) + K(tmax, ti);
            end
        end

        dW = dW * lambda;
        W(ni,:) = W(ni,:) - dW;
    end

end

end
end

end
