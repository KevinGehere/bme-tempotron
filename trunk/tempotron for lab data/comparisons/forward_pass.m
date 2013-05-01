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

for i = 1:twin  %8000 time points each point calculate vt
	Vs = zeros(Ns, 1); % ns -- no. of synapse, vs -- every time point/every synapse vt
	for j = 1:Ns % every synapse calculate the spike before time point vs
		indsp = find(stdata(j, 1:i));
		for k = 1:length(indsp)
			Vs(j, 1) = Vs(j, 1) + K(i, indsp(k)); % calculate PSP for each synapse
		end
	end
	Vt(1, i) = Vrest + w * Vs; % calculate weighted sum of PSP for all synapses
end
end