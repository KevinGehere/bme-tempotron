
VX = zeros(10,10);
TX = zeros(10,10);

for ii = 1:1
    for jj = 2:2    
        for kk = 1:10
        
        %pidx = jj;
        %nidx = [1:pidx-1 pidx+1:10];

        inspikes = images(:,inds(ii,jj));

        [~, TX(kk,ii), VX(kk,ii)] = feed_forward(inspikes, W(kk,:), T);
        end
    end
end
