function [coeff,num]=descripteurfouriernorm(z,cmax)
cmin=-cmax;
z_moy=mean(z);
longc=length(z);
% on calcule les coefficients de Fourier
TC=fft(z-z_moy)/longc;
num=cmin:cmax;
% on sélectionne les coefficients entre cmin et cmax
coeff=zeros(cmax-cmin+1,1);
coeff(end-cmax:end)=TC(1:cmax+1);
coeff(1:-cmin)=TC(end+cmin+1:end);

% on retourne la séquence si le parcours est dans le
% sens inverse su sens trigonométrique
if abs(coeff(num==-1))>abs(coeff(num==1))
    coeff=coeff(end:-1:1);
end

% corrections de phase pour normaliser
% par rapport à la rotation et l'origine
% du signal z
Phi=angle(coeff(num==-1).*coeff(num==1))/2;
coeff=coeff*exp(-1i*Phi);
theta=angle(coeff(num==1));
coeff=coeff.*exp(-1i*num'*theta);

% correction pour normaliser la taille
coeff=coeff/abs(coeff(num==1));
