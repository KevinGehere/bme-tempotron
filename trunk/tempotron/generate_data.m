Ns = 100;
Np = 1;
T = 500;


%pspikes = round((500-1) * rand(Ns, Np) + 1);
%nspikes = round((500-1) * rand(Ns, Np) + 1);
% adjust = (0:Np-1) * 500;
% 
% pinputs = zeros(Ns, T*Np);
% ninputs = zeros(Ns, T*Np);
% 
% for ii = 1:Ns
%     pspikes(ii,:) = pspikes(ii,:) + adjust;
%     pinputs(ii, pspikes(ii,:)) = 1;
%     
%     nspikes(ii,:) = nspikes(ii,:) + adjust;
%     ninputs(ii, nspikes(ii,:)) = 1;
% end

W = rands(10,Ns) ./ 100;