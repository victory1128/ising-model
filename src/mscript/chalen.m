function xi = chalen(T,sigma0,option)

N = option.N;
l = option.l;

gamma = characlength2D2(T,sigma0,option.param);

% xi xi1
%
s = find(gamma < 0, 1) - 1;
if isempty(s)
    s = N/2;
end
s = min(s,l);
if s > 1;
    p = polyfit((1:s)-1,log(gamma(1:s))',1);
    xi = -1/p(1);
else
    xi = 0;
end


% xi001
%{ 
s = find(gamma(2:end) > 0);
p = polyfit(s,log(gamma(s)),1);
xi = -1/p(1);
%}

%{
s = find(gamma(2:end) > 0);
p = polyfit(0:1,log(gamma(1:2))',1);
xi = -1/p(1);
%}

