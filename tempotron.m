%model parametrs

tau = 15;
taus = tau/4;

V0 = 2.12;

Vrest = 0;
Vthr = 1;

%PSP kernel
K = @(t,ti) (V0*(exp(-(t-ti)/tau) - exp(-(t-ti)/taus)));


input = zeros(3, 500);
input(1,:) = [0 1 0 0 1 0 1 0 0 0];
input(2,:) = [0 0 0 1 0 0 0 1 0 0];
input(3,:) = [0 1 0 0 0 0 0 1 0 0];

Kernel = zeros(3, 10);

W = rands(1,3);

V = zeros(1, 10);
for t = 1:10
    sumi = zeros(1, 3);
    for ti = 1:t
        for i = 1:3
            if input(i,ti) == 1
                sumi(i) = sumi(i) + K(t, ti);
            end
        end
    end
    V(t) = W*sumi';
end
            