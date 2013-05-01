
tshunt = 0;

V = zeros(2, Np*T);
for t = 1:Np*T
    sumi = zeros(1, Ns);
    
    if tshunt == 0
        tend = t;
    else
        tend = tshunt;
    end
    for ti = 1:tend
        for i = 1:Ns
            if inputs(i,ti) == 1
                sumi(i) = sumi(i) + K(t, ti);
            end
        end
    end
    V(t) = W*sumi';
    if V(t) > 1
        tshunt = t;
    end
end