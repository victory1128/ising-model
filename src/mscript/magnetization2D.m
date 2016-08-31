function m = magnetization2D(T,h,sigma0,param)

J = param.J;
kb = param.kb;
itermax = param.itermax;

beta = 1/(kb*T);
N= size(sigma0,1);
sigma = sigma0;
H = Hamiltonian(sigma,J,h);
S = sum(sum(sigma));
M = magnetization2D_cycle(H,sigma,J,h,beta,itermax,S);
m = M / (N^2);






