% critical energy with respect to the size of network N.


param.J = 1;
param.kb = 1;
param.h = 0;
param.itermax = 1e7;
Nc = [10,16,20,25,30,50,100]';
Tc = zeros(7,1);

parpool('local',2);
tic;

for j = 1:7
    
    N = Nc(j);
    temp = rand(N);
    sigma0 = ones(N);
    sigma0(temp > 0.5) = 1;
    sigma0(temp <= 0.5) = -1;
    T = 1:0.1:5;
    u = zeros(41,1);
    parfor i = 1:41
        u(i) = specificheat2D(T(i),sigma0,param);
    end
    [~,t] = max(u);
    Tc(j) = (t+9)*0.1;
end
toc
delete(gcp);

z = 1./(Nc.^2);
p = polyfit(z,Tc,1);


figure('color','w')
plot(z,Tc)
hold on
plot(z,p(1)*z+p(2))
title('\fontsize{16}Tc','fontweight','Bold','fontname','KaiTi')
xlabel('\fontsize{16}1/N^2','fontweight','Bold','fontname','KaiTi');
ylabel('\fontsize{16}Tc','fontweight','Bold','fontname','KaiTi');


figure('color','w')
plot(Nc,Tc)
title('\fontsize{16}Tc','fontweight','Bold','fontname','KaiTi')
xlabel('\fontsize{16}N','fontweight','Bold','fontname','KaiTi');
ylabel('\fontsize{16}Tc','fontweight','Bold','fontname','KaiTi');






