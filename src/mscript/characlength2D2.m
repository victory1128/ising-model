function gamma = characlength2D2(T,sigma0,param)

J = param.J;
kb = param.kb;
h = param.h;
itermax = param.itermax;

beta = 1/(kb*T);
N= size(sigma0,1);
sigma = sigma0;
H = Hamiltonian(sigma,J,h);
S = initialS(sigma);
gamma = characterlength2D2_cycle(H,sigma,J,h,beta,itermax,S);
if isrow(gamma)
    gamma = gamma';
end

end

function S = initialS(sigma)

N = size(sigma,1);
nS = N/2;
S = zeros(nS,1);
S(1) = 1;
for i = 1:(nS-1)
    sigmau = [sigma((N-i+1):N,:);sigma(1:(N-i),:)];
    sigmad = [sigma((i+1):N,:);sigma(1:i,:)];
    sigmar = [sigma(:,(N-i+1):N),sigma(:,1:(N-i))];
    sigmal = [sigma(:,(i+1):N),sigma(:,1:i)];
    S(i+1) = (sum(sum(sigmau.*sigma)) + sum(sum(sigmad.*sigma)) +...
        sum(sum(sigmar.*sigma)) + sum(sum(sigmal.*sigma)))/(N^2*4);
end

end

