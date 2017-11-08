function z_fil=resconstrdesfour(coeff,N,cmax)

cmin=-cmax;
TC=zeros(N,1);

TC(1:cmax+1)=coeff(end-cmax:end);
TC(end+cmin+1:end)=coeff(1:-cmin);

z_fil=ifft(TC)*N;

z_fil=[z_fil;z_fil(1)];