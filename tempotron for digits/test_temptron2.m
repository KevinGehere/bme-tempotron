
VX = zeros(200,1);
TX = zeros(200,1);

for ii = 21:200
    ii
    for jj = 1:10
    inspikes = images(:,inds(ii,jj));
    
    [~, ~, VX(ii,jj)] = feed_forward(inspikes, W, T);
    end
end
