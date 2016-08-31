% internal energy or specific heat with respect to T

kind = 1; % 1 for internal energy; 0 for specific heat.


param.J = 1;
param.kb = 1;
param.h = 0;
param.itermax = 1e8;
N = 10;

temp = rand(N);
sigma0 = ones(N);
sigma0(temp > 0.5) = 1;
sigma0(temp <= 0.5) = -1;
T = 1:0.1:5;
u = zeros(41,1);


parpool('local',2);
tic;

parfor i = 1:41
    if kind
       u(i) = internalenergy2D2(T(i),sigma0,param);
    else
       u(i) = specificheat2D(T(i),sigma0,param);
    end
end

toc
delete(gcp);
if kind
    figure('color','w')
    plot(T,u)
    title('\fontsize{16}internal energy','fontweight','Bold','fontname','KaiTi')
    xlabel('\fontsize{16}T','fontweight','Bold','fontname','KaiTi');
    ylabel('\fontsize{16}internal energy','fontweight','Bold','fontname','KaiTi');
else
    figure('color','w')
    plot(T,u)
    title('\fontsize{16}specific heat','fontweight','Bold','fontname','KaiTi')
    xlabel('\fontsize{16}T','fontweight','Bold','fontname','KaiTi');
    ylabel('\fontsize{16}specific heat','fontweight','Bold','fontname','KaiTi');
end





