% character length fit

param.J = 1;
param.kb = 1;
param.h = 0;
param.itermax = 1e6;
N = 100;

temp = rand(N);
sigma0 = ones(N);
sigma0(temp > 0.5) = 1;
sigma0(temp <= 0.5) = -1;
T = 2.269;

gamma = zeros(20,N/2);

parpool('local',2);
tic;
parfor i = 1:20
    gamma(i,:) = characlength2D2(T,sigma0,param);
end

toc

delete(gcp);


for i = 1:20
    plot(gamma(i,:),'b.');
    hold on;
end
plot(mean(gamma))

gamma = mean(gamma);

s = find(gamma(1:end) > 0);
p = polyfit(s-1,log(gamma(s)),1);
plot(s-1,log(gamma(s)))
hold on
plot(0:49,p(1)*(0:49) + p(2))






