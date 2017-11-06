4%Game of life testtessttest av ----------------------
%Programmet �r baserat p� matriser

%Start%

%Rensar
clear all
clc

%Intro
txt=['Det ultimata Game of Life!'];
disp(txt)
disp(' ')
pause(1)
a = 1;

%Dimensioner
txt=['Hur m�nga dimensioner ska cellernas universum vara? (2d, 3d eller 4d(experimentell))'];
disp(txt)
D = input (' ');

%Skapar 2d game of life
if D == 2

%Grids g�r s� att det blir konstigt ibland. S�tter in funktion s� att grids
%kan st�ngas av.
txt=['Vill ni ha grids? 1=JA, 2=NEJ'];
disp(txt);
pause(1);
grd=0;
grd=input(' ');
    
%---------------- kom p� hur man l�gger till grids och val av f�rbest�mda figurer!
txt=['Vill ni simulera en f�rbest�md figur? 1=JA, 2=NEJ'];
disp(txt);
pause(1);
aa=0;
ab=0;
aa=input(' ');

if aa==1
    txt=['V�nligen skriv 1 f�r figur 1 och 2 f�r figur 2'];
    disp(txt)
    pause(1);
    ab=input(' ');
end

%Skapar Figur 1
if ab==1
    
Universum=zeros(16,16);
Universum(5,7:11)=1;
Universum(5:9,5)=1;
Universum(7:11,11)=1;
Universum(11,5:9)=1;
M=16;
N=16;
InvUniversum = ~Universum;
figure;
imshow(InvUniversum,'InitialMagnification','fit');
drawnow;

%Fixar grids om man vill ha grids
if grd==1
axis on
axis square
grid on
set(gca,'xtick',(0.5:1:(M+0.5)))
set(gca,'xticklabel',(0:1:M))
set(gca,'ytick',(0.5:1:(N+0.5)))
set(gca,'yticklabel',(N:-1:0))
end

%Skapar Figur 2
elseif ab==2
    Universum=zeros(16,16);
Universum(5,7)=1;
Universum(5,10)=1;
Universum(6,7:10)=1;
Universum(7:9,6)=1;
Universum(8,8:9)=1;
Universum(7:9,11)=1;
Universum(10,7:10)=1;
M=16;
N=16;
InvUniversum = ~Universum;
figure;
imshow(InvUniversum,'InitialMagnification','fit');
drawnow;

%Fixar grids om man vill ha det
if grd==1
axis on
axis square
grid on
set(gca,'xtick',(0.5:1:(M+0.5)))
set(gca,'xticklabel',(0:1:M))
set(gca,'ytick',(0.5:1:(N+0.5)))
set(gca,'yticklabel',(N:-1:0))
end

else
txt=['Hur m�nga rader ska cellernas universum vara?'];
disp(txt)
M = 10;
M = input (' ');
txt=['Hur m�nga kolumner ska cellernas universum vara?'];
disp(txt)
N = 10;
N = input (' ');
pause(1)
Universum=zeros(M,N);

fraga=('Vill du ange en startpopulation? Ja=1 och Nej=2');
disp(fraga)
svar = input (' ');
k='Ange start population';
if svar==1
    disp(k)
    csvwrite('Universum.txt', Universum);
    open Universum.txt
kottbollar = input('Tryck p� enter n�r du �r klar (Kom ih�g att spara filen!) Exempelmatriser finns l�ngre ned i koden.');
Universum = importdata('Universum.txt');
else
    
%Randomiserar utspridning
txt=['Sprider celler slumpm�ssigt'];
disp(txt)
pause(1)
fprintf(1, '.');
pause(1)
fprintf(1, '.');
pause(1)
fprintf(1, '.');
pause(2)
Universum = randi([0 1], M,N);
end 
end

%Om man vill byta f�rg i image av cell fr�n svart till vitt:
InvUniversum = ~Universum; %Inv st�r f�r inverse

%Ritar universum i 2d
imshow(InvUniversum,'InitialMagnification','fit'); %inital magnification = ingen zoom, 'fit' = fixar s� att det ser bra ut
   drawnow;
   
   %------------- kom p� hur antalet celler r�knas i figuren. nnz = Number of Non Zero matrix elements
   xlabel(nnz(Universum));
if grd==1
axis on
axis square
grid on
set(gca,'xtick',(0.5:1:(M+0.5)))
set(gca,'xticklabel',(0:1:M))
set(gca,'ytick',(0.5:1:(N+0.5)))
set(gca,'yticklabel',(N:-1:0))
txt=['Vit ruta = tomt, Svart ruta = cell'];
disp(txt)
end

elseif D == 3
%Skapa 3d
txt=['Hur bred ska cellernas universum vara?'];
disp(txt)
M = 10;
M = input (' ');
txt=['Hur l�ng ska cellernas universum vara?'];
disp(txt)
N = 10;
N = input (' ');
txt=['Hur h�g ska cellernas universum vara?'];
disp(txt)
H = 10;
H = input (' ');
Universum=zeros(M,N,H);
txt=['Sprider celler slumpm�ssigt'];
disp(txt)
pause(1)
fprintf(1, '.');
pause(1)
fprintf(1, '.');
pause(1)
fprintf(1, '.');
pause(2)
Universum = randi([0 1], M,N,H);
[x y z] = ind2sub(size(Universum), find(Universum));
scatter3(x, y, z, 'k.');
%------------ kom p� hur antalet celler r�knas i figuren. nnz = Number of Non Zero matrix elements
xlabel(nnz(Universum));
rotate3d on

elseif D == 4
%Skapa 4d
txt=['Hur bred ska cellernas universum vara?'];
disp(txt)
M = 10;
M = input (' ');
txt=['Hur l�ng ska cellernas universum vara?'];
disp(txt)
N = 10;
N = input (' ');
txt=['Hur h�g ska cellernas universum vara?'];
disp(txt)
H = 10;
H = input (' ');
txt=['Hur m�nga parallella v�rldar ska cellernas universum vara?'];
disp(txt)
B = 3;
B = input (' ');
Universum=zeros(M,N,H,B);
Universum = randi([0 1], M,N,H,B);
rotate3d on

%Initial kod figurer
r=0;
q=0;

%Visar dimensioner i figurer
for q = 1:B
[x y z] = ind2sub(size(Universum(:,:,:,q)), find(Universum(:,:,:,q)));
w = subplot(1,B,q);
scatter3(x, y, z, 'k.');
%------------- kom p� hur antalet celler r�knas i figuren. nnz = Number of Non Zero matrix elements
xlabel(nnz(Universum));
%Vilken dimension
title(['V�rld ' num2str(q) ' '])
end

else
    disp('ERROR: Tryck Ctrl+c');
end

%Uppdateringstid
txt=['Hur snabbt ska simulation uppdateras? (I sekunder)'];
disp(txt)
t = 5;
t = input(' ');

%K�r
txt=['Starta simulation?'];
disp(txt)
x = input('Tryck Enter');

%Regler% 

if D == 2 %Om dimensionen �r 2
%Definerar vilka celler som �r grannar till cell
o=[1 1 1;1 0 1;1 1 1];

%G�r matris d�r siffra st�rr f�r summan av celler runt om dvs en grannmatris
Grannar = conv2(Universum,o,'same');

%Skriv in a = 1 f�r att avbryta eller tryck ctrl+c
a = 0;
txt=['Ctrl+c f�r att stoppa!'];
disp(txt)

%Loop!

while (a<1)
%Regler
Grannar(Grannar<2) = [0]; %Om grannar �r mindre �n 2: Cell d�r
Grannar(Grannar==3) = [1]; %Om grannar �r 3: Cell lever/blir ny cell
Grannar(Grannar>=4) = [0]; %Om grannar �r 4 eller mer: Cell d�r

%OBS: Om grannar �r 2 �ndras inget, dvs inget d�r eller skapas
Grannar(Grannar==2 & Universum==0) = [0]; %Ingenting f�rblir ingenting
Grannar(Grannar==2 & Universum==1) = [1]; %Cell f�rblir levande

%Nollst�ller
Universum = Grannar;

%Om man vill byta f�rg i image av cell fr�n svart till vitt
InvUniversum = ~Universum; %Inv st�r f�r inverse

%Uppdaterar bild
imshow(InvUniversum,'InitialMagnification','fit');
   drawnow;
   
   %----------------- kom p� hur antalet celler r�knas i figuren. nnz = Number of Non Zero matrix elements
xlabel(nnz(Universum));

if grd==1
axis on
axis square
grid on
set(gca,'xtick',(0.5:1:(M+0.5)))
set(gca,'xticklabel',(0:1:M))
set(gca,'ytick',(0.5:1:(N+0.5)))
set(gca,'yticklabel',(N:-1:0))
end

%Pausar en stund s� att det inte g�r f�r snabbt (uppdateringstid)
pause(t)

%R�knar om
Grannar = conv2(Universum,o,'same');
end

elseif D == 3

%Vilka grannar
o(:,:,1) = [1 1 1;1 1 1; 1 1 1];
o(:,:,2) = [1 1 1;1 0 1; 1 1 1];
o(:,:,3) = [1 1 1;1 1 1; 1 1 1];

%G�r matris d�r siffra st�r f�r summan av celler runt om dvs en grannmatris
Grannar = convn(Universum,o,'same');

%Skriv in a = 1 f�r att avbryta eller tryck ctrl+c
a = 0;
txt=['Ctrl+c f�r att stoppa!'];
disp(txt)
    
while (a<1)

%Regler 3d (�ndra, pga test med grannar visar m�nga grannar) De h�r
%reglerna �r bra
Grannar(Grannar<7) = [0]; %Om grannar �r mindre �n 7: Cell d�r
Grannar(Grannar==11) = [1]; %Om grannar �r 11: Cell lever/blir ny cell
Grannar(Grannar>=12) = [0]; %Om grannar �r 12 eller mer: Cell d�r

%OBS: Om grannar �r 7 till 11 �ndras inget, dvs inget d�r eller skapas
Grannar(Grannar>=7 & Grannar<10 & Universum==0) = [0]; %Ingenting f�rblir ingenting
Grannar(Grannar>=7 & Grannar<10 & Universum==1) = [1]; %Cell f�rblir levande

%Nollst�ller
Universum = Grannar;

%Plottar
[x y z] = ind2sub(size(Universum), find(Universum)); %hittar "koordinater"
scatter3(x, y, z, 'k.'); %plottar koordinater
%----------- kom p� hur antalet celler r�knas i figuren. nnz = Number of Non Zero matrix elements
xlabel(nnz(Universum));
rotate3d on

%Pausar en stund s� att det inte g�r f�r snabbt (uppdateringstid)
pause(t)

%R�knar om
Grannar = convn(Universum,o,'same');
end


%Denna kod tog v�ldigt l�ng tid att klura ut, men den fungerar!
elseif D == 4

%Vilka grannar 4d total
o(:,:,1,1) = [1 1 1;1 1 1; 1 1 1];
o(:,:,2,1) = [1 1 1;1 1 1; 1 1 1];
o(:,:,3,1) = [1 1 1;1 1 1; 1 1 1];
o(:,:,1,2) = [1 1 1;1 1 1; 1 1 1];
o(:,:,2,2) = [1 1 1;1 0 1; 1 1 1];
o(:,:,3,2) = [1 1 1;1 1 1; 1 1 1];
o(:,:,1,3) = [1 1 1;1 1 1; 1 1 1];
o(:,:,2,3) = [1 1 1;1 1 1; 1 1 1];
o(:,:,3,3) = [1 1 1;1 1 1; 1 1 1];

%G�r matris d�r siffra st�r f�r summan av celler runt om dvs en grannmatris
Grannar = convn(Universum,o,'same');

%Skriv in a = 1 f�r att avbryta eller tryck ctrl+c
a = 0;
txt=['Ctrl+c f�r att stoppa!'];
disp(txt)

while (a<1)
%Regler 4d (�ndra, pga test med grannar visar m�nga grannar)
Grannar(Grannar<17) = [0]; %Om grannar �r mindre �n 17: Cell d�r
Grannar(Grannar>=27 & Grannar<=31) = [1]; %Om grannar �r mellan 27 och 31: Cell lever/blir ny cell
Grannar(Grannar>=33) = [0]; %Om grannar �r 33 eller mer: Cell d�r

%OBS: Om grannar �r 20 till 25 �ndras inget, dvs inget d�r eller skapas
Grannar(Grannar>=17 & Grannar<27 & Universum==0) = [0]; %Ingenting f�rblir ingenting
Grannar(Grannar>=17 & Grannar<27 & Universum==1) = [1]; %Cell f�rblir levande

%EXTRA REGLER
%OBS: Om grannar �r 31 till 32 �ndras inget, dvs inget d�r eller skapas
Grannar(Grannar>31 & Grannar<33 & Universum==0) = [0]; %Ingenting f�rblir ingenting
Grannar(Grannar>31 & Grannar<33 & Universum==1) = [1]; %Cell f�rblir levande

%Nollst�ller
Universum = Grannar;

%Initial kod figurer
r=0;
q=0;

%Visar dimensioner i figurer
for q = 1:B
[x y z] = ind2sub(size(Universum(:,:,:,q)), find(Universum(:,:,:,q)));
w = subplot(1,B,q);
scatter3(x, y, z, 'k.');
%Vilken dimension
title(['V�rld ' num2str(q) ' '])
end

%----------- kom p� hur antalet celler r�knas i figuren. nnz = Number of Non Zero matrix elements
xlabel(nnz(Universum));

rotate3d on

%Pausar. OBS! L�ng paustid beh�vs!
pause(t)

%R�knar om
Grannar = convn(Universum,o,'same');
end
end

%5-d ocks�? ;)
