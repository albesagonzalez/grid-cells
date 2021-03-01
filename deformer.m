S_0 = load('Results/Constants/initial_S.mat').S_0;
n = 128;
size(S_0)
Z = reshape(S_0,[n, n]);
 figure(1)
 surf(Z)
k = 1.1;
n_ex = fix(n*k)
Z_ex = zeros(n_ex);
%Z = k*Z;
for i = 1:n_ex
    for j = 1:n_ex
        i_in = fix(i/k) + 1;
        j_in = fix(j/k) + 1;
        Z_ex(i, j) = Z(i_in, j_in);
    end
end

margin = fix((n_ex - n)/2);
in_range = margin:(n_ex - margin - 1);
Z_zoomed = Z_ex(in_range, in_range);
 figure(2)
 surf(Z_zoomed)
size(Z_zoomed)
S_0 = reshape(Z_zoomed, [1, n*n]);

save('Results/Tables/homothety_1_1.mat', 'S_0')

% figure(1)
% surf(Z)
% view(0, 90)
% Z(Z > 0.05) = 0.3*Z(Z > 0.05) + 0.7*0.5;
% figure(1)
% surf(Z)
% view(0, 90)
% S_amp = Z;
% save('Results/Tables/amplified.mat', 'S_amp')

%  figure(1)
% % surf(Z)
% % view(0, 90)
% % F = fft2(Z);
% % % F2 = log(abs(F));
% % % imshow(F2,[-1 5],'InitialMagnification','fit');
% % figure(2)
% S_10 = imrotate(Z, 10, 'crop');
% save('Results/Tables/rotated_10.mat', 'S_10')
% surf(S_10)
% view(0, 90)
% F2_rot = log(abs(F_rot));
% imshow(F2_rot,[-1 5],'InitialMagnification','fit');
% colormap(jet); colorbar


% tform = affine2d([0 0 0; 0 0 0; 0 0 0]);
% %BCenterOutput = imwarp(Z,tform,'OutputView',centerOutput);
% J = imwarp(Z,tform);
% figure
% imshow(J)