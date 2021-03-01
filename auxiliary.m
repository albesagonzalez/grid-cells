% S = load('Results/Tables/lambda_20.mat').S;
% n = 128
% Z = reshape(S(end, :),[n,n]);
% a = -n/2;
% step = 1;
% b = n/2 - 0.5;
% [X,Y] = meshgrid(a:step:b);
% figure(1)
% surf(X, Y, Z)
% colorbar;
% xlabel('x', 'Fontsize', 20)
% ylabel('y', 'Fontsize', 20)
% title('Pattern after 5s, \lambda = 20', 'Fontsize', 20)
% view(0, 90)
% 
% 
% S = load('Results/Tables/lambda_16.mat').S;
% Z = reshape(S(end, :),[128,128]);
% a = -n/2;
% step = 1;
% b = n/2 - 0.5;
% [X,Y] = meshgrid(a:step:b);
% figure(2)
% surf(X, Y, Z)
% xlabel('x', 'Fontsize', 20)
% ylabel('y', 'Fontsize', 20)
% colorbar;
% title('Pattern after 5s, \lambda = 16', 'Fontsize', 20)
% view(0, 90)
% %
% S = load('Results/Tables/lambda_40.mat').S;
% Z = reshape(S(end, :),[128,128]);
% a = -n/2;
% step = 1;
% b = n/2 - 0.5;
% [X,Y] = meshgrid(a:step:b);
% figure(3)
% surf(X, Y, Z)
% colorbar;
% xlabel('x', 'Fontsize', 20)
% ylabel('y', 'Fontsize', 20)
% title('Pattern after 5s, \lambda = 40', 'Fontsize', 20)
% view(0, 90)

n = 128;
S = load('Results/Constants/initial_S.mat').S_0;
size(S)
Z = reshape(S(end, :),[128,128]);
a = -n/2;
step = 1;
b = n/2 - 0.5;
[X,Y] = meshgrid(a:step:b);
figure(4)
surf(X, Y, Z)
colorbar;
xlabel('x', 'Fontsize', 20)
ylabel('y', 'Fontsize', 20)
title('Experimental S.S.', 'Fontsize', 20)
view(0, 90)

