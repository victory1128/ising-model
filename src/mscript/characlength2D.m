function gamma = characlength2D(T,sigma0,param)

J = param.J;
kb = param.kb;
h = param.h;
itermax = param.itermax;

beta = 1/(kb*T);
N= size(sigma0,1);
sigma = sigma0;
H = Hamiltonian(sigma,J,h);
S = sigma*sigma(1,1);
gamma = characlength2D_cycle(H,sigma,J,h,beta,itermax,S);

