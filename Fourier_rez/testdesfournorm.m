function testdesfournorm

close all

N=200;
Nangles=500;
dico=16;
numiter=50;
cmax=10;
cmin=-cmax;
listeangles=180*(1-2*rand(Nangles,1));
liste=dir('*.pgm');
Nimages=length(liste);
figure
for n=1:Nimages
    subplot(2,3,n)
    ima=lirepgm(liste(n).name);
    ima=double(ima<0.5);
    imshow(ima)
    drawnow
end

tabcoeff=zeros(cmax-cmin+1,length(listeangles));
vecteurs=zeros(2*(cmax-cmin+1),length(listeangles));
tabcontfil=zeros(N+1,length(listeangles));
for n=1:length(listeangles)
%    choix=randi(Nimages,1);
    choix=1+floor(Nimages*rand(Nimages,1));
    ima=double(lirepgm(liste(choix).name)<0.5);
    imar=imrotate(ima,listeangles(n),'nearest','crop');
    z=suivicont(imar);
    [coeff,ncoeff]=descripteurfouriernorm(z,cmax);
    tabcoeff(:,n)=coeff;
    contfil=resconstrdesfour(coeff,N,cmax);
    tabcontfil(:,n)=contfil;
    vecteurs(:,n)=[real(coeff);imag(coeff)];
end    
figure
plot(real(tabcontfil),imag(tabcontfil),'-',real(tabcontfil(1,:)),imag(tabcontfil(1,:)),'o')
title('contours associées aux coefficients normalisés')
grid on
axis equal
axis ij
drawnow
figure
plot(ncoeff,abs(tabcoeff))
title('module des coefficients')
xlabel('k');
ylabel('d_k');
grid on
zoom on
drawnow
figure
plot(vecteurs)
title('partie réellle et imaginaire des coefficients normalisés')
set(gca,'XTick',1:size(vecteurs,1))
set(gca,'XTickLabel',[ncoeff ncoeff])
grid on
ech=axis;
axis([1 size(vecteurs,1) ech(3:4)])
drawnow

vecteursliste=kmoyennes(vecteurs,dico,numiter);

figure
for n=1:dico
    contfil=resconstrdesfour(vecteursliste(1:end/2,n)+1i*vecteursliste(end/2+1:end,n),N,cmax);
    subplot(4,4,n)
    h=plot(real(contfil),imag(contfil),'-',real(contfil(1)),imag(contfil(1)),'o');
    title(['prototype ' int2str(n)])
    set(h(1),'LineWidth',2)
    set(h(2),'LineWidth',3)
    grid on
    axis equal
    axis ij
    drawnow
end
