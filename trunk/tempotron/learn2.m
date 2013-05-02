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
K = @(t,ti) (t>ti)*(V0*(exp(-(t-ti)/tau) - exp(-(t-ti)/taus)));

lambda = 0.002;
classid = 3;

%inspikes = round((500-1) * rand(Ns, Np) + 1);
W = rand(1,Ns) ./ 100;
VMX = zeros(30,10,5);

for epoch = 1:25
epoch
tic
for ii = 1:20
for jj = 1:10
%jj
    
inspikes = images(:,inds(ii,jj));
%pidx = 1;
%nidx = [1:pidx-1 pidx+1:2];

[V, tmax, vmax] = feed_forward(inspikes, W, T);
%vmax
VMX(epoch, jj, ii) = vmax;

falsePos = (jj == classid && vmax < Vthr);
falseNeg = (jj ~= classid && vmax >= Vthr);

if (falsePos || falseNeg)
    dW = zeros(1, Ns);
    for i = 1:Ns
        dW(i) = dW(i) + K(tmax, inspikes(i));
    end

    dW = (falsePos - falseNeg) * dW * lambda;
    W = W + dW;
end    


end
end
toc
end

