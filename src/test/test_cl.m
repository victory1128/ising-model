% character length with respect to temperature T 

param.J = 1;
param.kb = 1;
param.h = 0;
param.itermax = 1e8;

N= 50;
T = 2.269;
option.N = N;
option.l = 30;
option.param = param;

temp = rand(N);
sigma0 = ones(N);
sigma0(temp > 0.5) = 1;
sigma0(temp <= 0.5) = -1;

%{
T = 1:0.1:5;
xi = zeros(41,1);
%}
%beta = 0.43:0.0003:0.46;
%T = 1 ./ beta;
%T = 2.2:0.001:2.3;
T = 2:0.025:3;

xi = zeros(1,41);
parpool('local',2);
tic;
parfor i = 1:41
    xi(i) = chalen(T(i),sigma0,option);
end
toc
delete(gcp);

figure('color','w')
plot(T,xi,'b*')

title('\fontsize{16}character length','fontweight','Bold','fontname','KaiTi')
xlabel('\fontsize{16}T','fontweight','Bold','fontname','KaiTi');
ylabel('\fontsize{16}character length','fontweight','Bold','fontname','KaiTi');




