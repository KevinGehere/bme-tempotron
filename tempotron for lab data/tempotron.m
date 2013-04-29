function w = tempotron(train1, train2)
tau = 15;
taus = tau/4;
V0 = 2.12;
%PSP kernel
K = @(t1,t2) (V0*(exp(-(t1-t2)/tau) - exp(-(t1-t2)/taus)));

Ns = size(train1{1}, 1);
Ntrial = size(train2, 2);

Niter = 30;
lamda = 0.1;
w = 0.001 * rand(1, Ns);
Vthr = 1;
error = zeros(Niter, 1);

tic
for i = 1:Niter
	iclass = randi(2,1);
	itrial = randi(Ntrial, 1);
	stdata = eval(['train', num2str(iclass), '{1, ',num2str(itrial),'}']);
	Vt = forward_pass(stdata, w);
	[Vtmax, tmax] = max(Vt);
		
	if iclass == 1 && Vtmax < Vthr
		Ve = zeros(1, Ns);
		for j = 1:Ns
			indsp = find(stdata(j, 1:tmax));
			for k = 1:length(indsp)
				Ve(1, j) = Ve(1, j) + K(tmax, indsp(k));
			end
		end
		w = w + lamda * Ve;
		error(i) = 1;
	elseif iclass == 2 && Vtmax >= Vthr
		Ve = zeros(1, Ns);
		for j = 1:Ns
			indsp = find(stdata(j, 1:tmax));
			for k = 1:length(indsp)
				Ve(1, j) = Ve(1, j) + K(tmax, indsp(k));
			end
		end
		w = w - lamda * Ve;
		error(i) = 1;
	else
		error(i) = -1;
	end
end
toc

end