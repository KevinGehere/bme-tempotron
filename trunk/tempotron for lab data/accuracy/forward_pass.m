function Vt = forward_pass(stdata, w)
tau = 30;
taus = tau/4;
V0 = 2.12;
%PSP kernel
K = @(t1,t2) (V0*(exp(-(t1-t2)/tau) - exp(-(t1-t2)/taus)));

Ns = size(stdata, 1);
twin = size(stdata, 2);
Vrest = 0;
Vt = zeros(1, twin);

for i = 1:twin
	Vs = zeros(Ns, 1);
	for j = 1:Ns
		indsp = find(stdata(j, 1:i));
		for k = 1:length(indsp)
			Vs(j, 1) = Vs(j, 1) + K(i, indsp(k));
		end
	end
	Vt(1, i) = Vrest + w * Vs;
end
end