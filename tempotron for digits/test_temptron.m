
VX = zeros(10,10);
TX = zeros(10,10);

for ii = 1:5
    for jj = 3:3    
        for kk = jj:jj;

        inspikes = images(:,inds(ii,jj));

        [~, TX(kk,ii), VX(kk,ii)] = feed_forward(inspikes, W(kk,:), T);
        end
    end
end
