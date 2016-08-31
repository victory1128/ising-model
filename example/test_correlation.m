% correlation function


param.J = 1;
param.kb = 1;
param.h = 0;
param.itermax = 1e8;
N = 200;

temp = rand(N);
sigma0 = ones(N);
sigma0(temp > 0.5) = 1;
sigma0(temp <= 0.5) = -1;
T = 4;

gamma = zeros(4,N/2);
T = [2,2.269,3,4];


parpool('local',2);
tic;
parfor i = 1:4
    gamma(i,:) = characlength2D2(T(i),sigma0,param);
end
toc
delete(gcp)



figure('color','w')
subplot(221)
plot(0:(N/2-1),gamma(1,:))
title('\fontsize{16}correlation function T = 2','fontweight','Bold','fontname','KaiTi')
xlabel('\fontsize{16}r','fontweight','Bold','fontname','KaiTi');
ylabel('\fontsize{16}correlation','fontweight','Bold','fontname','KaiTi');
subplot(222)
plot(0:(N/2-1),gamma(2,:))
title('\fontsize{16}correlation function T = 2.269','fontweight','Bold','fontname','KaiTi')
xlabel('\fontsize{16}r','fontweight','Bold','fontname','KaiTi');
ylabel('\fontsize{16}correlation','fontweight','Bold','fontname','KaiTi');
subplot(223)
plot(0:(N/2-1),gamma(3,:))
title('\fontsize{16}correlation function T = 3','fontweight','Bold','fontname','KaiTi')
xlabel('\fontsize{16}r','fontweight','Bold','fontname','KaiTi');
ylabel('\fontsize{16}correlation','fontweight','Bold','fontname','KaiTi');
subplot(224)
plot(0:(N/2-1),gamma(4,:))
title('\fontsize{16}correlation function T = 4','fontweight','Bold','fontname','KaiTi')
xlabel('\fontsize{16}r','fontweight','Bold','fontname','KaiTi');
ylabel('\fontsize{16}correlation','fontweight','Bold','fontname','KaiTi');


