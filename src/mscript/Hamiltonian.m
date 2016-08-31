function ham = Hamiltonian(sigma,J,h)

%%
% HAMILTONIAN the Hamiltonian of 2D Ising model
%   H(sigma) = -J\sum_{<i,j>}sigma_i*sigma_j - h \sum_{i}sigma_i
%
% Input
%   sigma: the configuration of the spin system, N by N matrix
%   J: the parameter of the term of pair interactions
%   h: the external magnetic strength
%
% Output 
%   ham: the Hamiltonian
%
%%

[M,N] = size(sigma);
sigma1 = [sigma(M,:);sigma(1:(M-1),:)];
sigma2 = [sigma(:,N),sigma(:,1:(N-1))];
term1 = sum(sum(sigma1.*sigma)) + sum(sum(sigma2.*sigma));
term2 = sum(sum(sigma));
ham = -J*term1 - h*term2; 
