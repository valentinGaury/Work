function Z=suivicont(IMA)
% variables globales
global indl
global indc
global z
global ima
% tableaux d'index en ligne et en colonne
% pour balayer le voisinage
indl=[-1 -1 -1 0 1 1  1  0 -1];
indc=[-1  0  1 1 1 0 -1 -1 -1];
% tableau des points du contour
z=zeros(1000,1);
ima=IMA;
[N,M]=size(ima);

% on cherche le premier point du contour
trouve=0;
for n=1:N
   for m=1:M
      if (ima(n,m)==1)&&(trouve==0)
         longc=suivcont(n,m);
         trouve=1;
      end
   end
end
% on tronque le tableau pour ne conserver
% que les points du contour
z(longc+1:end)=[];
Z=z;

function longc=suivcont(n,m)
% variables globales
global indl
global indc
global z
global ima
% premier point du contour
z(1)=m+1i*n;
% la valeur 2 marque le point du contour
ima(n,m)=2;
index=2;
longc=2;
fin=0;
while fin==0
   trouve=0;
   % on balaye le voisinage
   for k=1:8
      if (ima(n+indl(k),m+indc(k))==0)&&...
            (ima(n+indl(k+1),m+indc(k+1))==1)&&(trouve==0)
         trouve=1;
         % on marque le point du contour
         ima(n+indl(k+1),m+indc(k+1))=2;
         % on m�morise les coordonn�es
         z(index)=(m+indc(k+1))+1i*(n+indl(k+1));
         % on met � jour le point conrant
         n=n+indl(k+1);
         m=m+indc(k+1);
         if(longc<index)
            longc=index;
         end
         index=index+1;
      end
   end
   if(trouve==0)
      % si on ne trouve plus de point on
      % revient en arri�re
      index=index-1;
      m=real(z(index));
      n=imag(z(index));
   end
   % lorsqu'il n'y a plus de points � trouver
   % la recherche du contour est termin�e
   if index==1
      fin=1;
   end
end


