mu = 0;
sigma1 = [0.5 0.5];
sigma2 = [1.0 1.0];

DoG1 = @(x,y) (mvnpdf([x y], mu, sigma1) - mvnpdf([x y], mu, 3*sigma1));
DoG2 = @(x,y) (mvnpdf([x y], mu, sigma2) - mvnpdf([x y], mu, 3*sigma2));

%GC1mat = zeros(10000, 100);
% for im = 1:10000
% 
% img = reshape(images(:,im),28,28);
% zrs = zeros(28,1);
% img = [zrs img zrs];
% zrs = [0 zrs' 0];
% img = [zrs; img; zrs];
% 
% GC1ON = zeros(10,10);
% 
% for ii = 1:length(GC1ON)
%     for jj = 1:length(GC1ON)
%         sum = 0;
% %         ci = (ii-1)*3+2;
% %         cj = (jj-1)*3+2;
%         for ki = 1:3
%             for kj = 1:3
%                 sum = sum + img((ii-1)*3+ki, (jj-1)*3+kj) * DoG1(ki-2, kj-2);
%             end
%         end
%         GC1ON(ii,jj) = sum;
%     end
% end
% im
% GC1mat(im,:) = reshape(GC1ON,1,100);
% end

GC2mat = zeros(10000, 25);

for im = 1:10000

img = reshape(images(:,im),28,28);
zrs = zeros(28,1);
img = [zrs img zrs];
zrs = [0 zrs' 0];
img = [zrs; img; zrs];

GC2ON = zeros(5,5);

for ii = 1:length(GC2ON)
    for jj = 1:length(GC2ON)
        sum = 0;
%         ci = (ii-1)*3+2;
%         cj = (jj-1)*3+2;
        for ki = 1:6
            for kj = 1:6
                sum = sum + img((ii-1)*6+ki, (jj-1)*6+kj) * DoG2(ki-3.5, kj-3.5);
            end
        end
        GC2ON(ii,jj) = sum;
    end
end
im
GC2mat(im,:) = reshape(GC2ON,1,25);
end

% GC1OFF = zeros(10,10); 
% GC2OFF = zeros(5,5);
