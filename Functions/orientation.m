
function grid_angles= orientation(filename , time)
network = load(filename).S_0;
S_=S(1, :);
N = length(S_(1,:));
n = sqrt(N);

center = [round(n/2)+1,round(n/2)+1];
if network.periodic
    window_width=35;
else
    window_width=9;
end

grid_angles=[];
for t = 1:1:length(S(:, 1))
    if rem(t, 1200) == 1
        disp(time(t)) ;
        S_t = S(t, :);
        angles=get_angles(S_t, window_width, center);
        grid_angles(end+1,:)=cat(2, angles, time(t) ) ;
    end
end

function angle=Arcos(v, v_ref)
    v=v/norm(v);v_ref=v_ref/norm(v_ref);
    if v(2)>=0
        angle=acos(dot(v_ref, v));
    else 
        angle=pi-acos(dot(v_ref, v));
    end
end 
function angles = get_angles(S_t, window_width , center)
    radius = fix(window_width/2);
    Z = reshape(S_t,[n, n]);
    Z_fft=abs(fftshift( fft2(Z) ) ) ;
%     figure(10)
%     imagesc(Z_fft);
    Z_window=Z_fft(center(1)-radius:center(1)+radius,center(2)-radius:center(2)+radius );
    figure(11)
    imagesc(Z_window);
    S_window = reshape(Z_window,[window_width^2, 1]);
    [max, I] = maxk(S_window, 7); %find 7 maxima
    points=[fix(I/window_width),rem(I,window_width)-1]-[radius, radius]+center;
    figure(15)
    scatter(points(:,1), points(:,2));
    sorted_points=sortrows(points);
    v_ref=[1,0]; % horizontal axis -> reference
    v1=sorted_points(7,:)-sorted_points(1,:);
    v2=sorted_points(6,:)-sorted_points(2,:) ;
    v3=sorted_points(5,:)-sorted_points(3,:);
    angles=[ Arcos(v1, v_ref), Arcos(v2 , v_ref) , Arcos(v3, v_ref) ]; %*180/pi;
    angles=sort(angles)
end
end