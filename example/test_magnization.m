% magnization with respect to the external field h in different
% temperature.


param.J = 1;
param.kb = 1;
param.h = 0;
param.itermax = 1e7;
N = 100;

temp = rand(N);
sigma0 = ones(N);
sigma0(temp > 0.5) = 1;
sigma0(temp <= 0.5) = -1;
%T = 2.269;
h = -5:0.1:5;
u = zeros(4,101);
T = [1,2.269,3,4];
parpool('local',2);
tic;
for j = 1:4
    parfor i = 1:101
        u(j,i) = magnetization2D(T(j),h(i),sigma0,param);
    end
end
toc
delete(gcp);

figure('color','w')
subplot(221)
plot(h,u(1,:))
title('\fontsize{16}magnetization T = 1','fontweight','Bold','fontname','KaiTi')
xlabel('\fontsize{16}h','fontweight','Bold','fontname','KaiTi');
ylabel('\fontsize{16}magnetization','fontweight','Bold','fontname','KaiTi');
subplot(222)
plot(h,u(2,:))
title('\fontsize{16}magnetization T = 2.269','fontweight','Bold','fontname','KaiTi')
xlabel('\fontsize{16}h','fontweight','Bold','fontname','KaiTi');
ylabel('\fontsize{16}magnetization','fontweight','Bold','fontname','KaiTi');
subplot(223)
plot(h,u(3,:))
title('\fontsize{16}magnetization T = 3','fontweight','Bold','fontname','KaiTi')
xlabel('\fontsize{16}h','fontweight','Bold','fontname','KaiTi');
ylabel('\fontsize{16}magnetization','fontweight','Bold','fontname','KaiTi');
subplot(224)
plot(h,u(4,:))
title('\fontsize{16}magnetization T = 4','fontweight','Bold','fontname','KaiTi')
xlabel('\fontsize{16}h','fontweight','Bold','fontname','KaiTi');
ylabel('\fontsize{16}magnetization','fontweight','Bold','fontname','KaiTi');


