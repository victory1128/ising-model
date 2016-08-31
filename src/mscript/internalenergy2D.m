function u = internalenergy2D(T,sigma0,param)

J = param.J;
kb = param.kb;
h = param.h;
itermax = param.itermax;

beta = 1/(kb*T);
N= size(sigma0,1);
U = 0; 
sigma = sigma0;
H = Hamiltonian(sigma,J,h);
for i = 1:itermax
    loc = randi(N,1,2);
    row = loc(1,1);
    col = loc(1,2);
    %  new - original
    if row == 1 
        drow = N;
        urow = row+1;
    elseif row == N
        drow = row-1;
        urow = 1;
    else
        drow = row - 1;
        urow = row + 1;
    end
    
    if col == 1
        lcol = N;
        rcol = col+1;
    elseif col == N
        lcol = col-1;
        rcol = 1;
    else
        lcol = col-1;
        rcol = col+1;
    end
        
    
    deltaH = 2*J*sigma(row,col)*(sigma(drow,col)+sigma(urow,col)+...
        sigma(row,lcol)+sigma(row,rcol)) + 2*h*sigma(row,col);
    A = min(1,exp(-beta*deltaH));
    r = rand(1);
    if r < A
        sigma(row,col) = -sigma(row,col);
        H = H + deltaH;
    end
    U = U + H;
end

U = U/itermax;
u = U/(N^2);






