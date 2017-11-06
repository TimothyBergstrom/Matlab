4%Game of life testtessttest av ----------------------
%Programmet är baserat på matriser

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
txt=['Hur många dimensioner ska cellernas universum vara? (2d, 3d eller 4d(experimentell))'];
disp(txt)
D = input (' ');

%Skapar 2d game of life
if D == 2

%Grids gör så att det blir konstigt ibland. Sätter in funktion så att grids
%kan stängas av.
txt=['Vill ni ha grids? 1=JA, 2=NEJ'];
disp(txt);
pause(1);
grd=0;
grd=input(' ');
    
%---------------- kom på hur man lägger till grids och val av förbestämda figurer!
txt=['Vill ni simulera en förbestämd figur? 1=JA, 2=NEJ'];
disp(txt);
pause(1);
aa=0;
ab=0;
aa=input(' ');

if aa==1
    txt=['Vänligen skriv 1 för figur 1 och 2 för figur 2'];
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
txt=['Hur många rader ska cellernas universum vara?'];
disp(txt)
M = 10;
M = input (' ');
txt=['Hur många kolumner ska cellernas universum vara?'];
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
kottbollar = input('Tryck på enter när du är klar (Kom ihåg att spara filen!) Exempelmatriser finns längre ned i koden.');
Universum = importdata('Universum.txt');
else
    
%Randomiserar utspridning
txt=['Sprider celler slumpmässigt'];
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

%Om man vill byta färg i image av cell från svart till vitt:
InvUniversum = ~Universum; %Inv står för inverse

%Ritar universum i 2d
imshow(InvUniversum,'InitialMagnification','fit'); %inital magnification = ingen zoom, 'fit' = fixar så att det ser bra ut
   drawnow;
   
   %------------- kom på hur antalet celler räknas i figuren. nnz = Number of Non Zero matrix elements
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
txt=['Hur lång ska cellernas universum vara?'];
disp(txt)
N = 10;
N = input (' ');
txt=['Hur hög ska cellernas universum vara?'];
disp(txt)
H = 10;
H = input (' ');
Universum=zeros(M,N,H);
txt=['Sprider celler slumpmässigt'];
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
%------------ kom på hur antalet celler räknas i figuren. nnz = Number of Non Zero matrix elements
xlabel(nnz(Universum));
rotate3d on

elseif D == 4
%Skapa 4d
txt=['Hur bred ska cellernas universum vara?'];
disp(txt)
M = 10;
M = input (' ');
txt=['Hur lång ska cellernas universum vara?'];
disp(txt)
N = 10;
N = input (' ');
txt=['Hur hög ska cellernas universum vara?'];
disp(txt)
H = 10;
H = input (' ');
txt=['Hur många parallella världar ska cellernas universum vara?'];
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
%------------- kom på hur antalet celler räknas i figuren. nnz = Number of Non Zero matrix elements
xlabel(nnz(Universum));
%Vilken dimension
title(['Värld ' num2str(q) ' '])
end

else
    disp('ERROR: Tryck Ctrl+c');
end

%Uppdateringstid
txt=['Hur snabbt ska simulation uppdateras? (I sekunder)'];
disp(txt)
t = 5;
t = input(' ');

%Kör
txt=['Starta simulation?'];
disp(txt)
x = input('Tryck Enter');

%Regler% 

if D == 2 %Om dimensionen är 2
%Definerar vilka celler som är grannar till cell
o=[1 1 1;1 0 1;1 1 1];

%Gör matris där siffra stårr för summan av celler runt om dvs en grannmatris
Grannar = conv2(Universum,o,'same');

%Skriv in a = 1 för att avbryta eller tryck ctrl+c
a = 0;
txt=['Ctrl+c för att stoppa!'];
disp(txt)

%Loop!

while (a<1)
%Regler
Grannar(Grannar<2) = [0]; %Om grannar är mindre än 2: Cell dör
Grannar(Grannar==3) = [1]; %Om grannar är 3: Cell lever/blir ny cell
Grannar(Grannar>=4) = [0]; %Om grannar är 4 eller mer: Cell dör

%OBS: Om grannar är 2 ändras inget, dvs inget dör eller skapas
Grannar(Grannar==2 & Universum==0) = [0]; %Ingenting förblir ingenting
Grannar(Grannar==2 & Universum==1) = [1]; %Cell förblir levande

%Nollställer
Universum = Grannar;

%Om man vill byta färg i image av cell från svart till vitt
InvUniversum = ~Universum; %Inv står för inverse

%Uppdaterar bild
imshow(InvUniversum,'InitialMagnification','fit');
   drawnow;
   
   %----------------- kom på hur antalet celler räknas i figuren. nnz = Number of Non Zero matrix elements
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

%Pausar en stund så att det inte går för snabbt (uppdateringstid)
pause(t)

%Räknar om
Grannar = conv2(Universum,o,'same');
end

elseif D == 3

%Vilka grannar
o(:,:,1) = [1 1 1;1 1 1; 1 1 1];
o(:,:,2) = [1 1 1;1 0 1; 1 1 1];
o(:,:,3) = [1 1 1;1 1 1; 1 1 1];

%Gör matris där siffra står för summan av celler runt om dvs en grannmatris
Grannar = convn(Universum,o,'same');

%Skriv in a = 1 för att avbryta eller tryck ctrl+c
a = 0;
txt=['Ctrl+c för att stoppa!'];
disp(txt)
    
while (a<1)

%Regler 3d (ändra, pga test med grannar visar många grannar) De här
%reglerna är bra
Grannar(Grannar<7) = [0]; %Om grannar är mindre än 7: Cell dör
Grannar(Grannar==11) = [1]; %Om grannar är 11: Cell lever/blir ny cell
Grannar(Grannar>=12) = [0]; %Om grannar är 12 eller mer: Cell dör

%OBS: Om grannar är 7 till 11 ändras inget, dvs inget dör eller skapas
Grannar(Grannar>=7 & Grannar<10 & Universum==0) = [0]; %Ingenting förblir ingenting
Grannar(Grannar>=7 & Grannar<10 & Universum==1) = [1]; %Cell förblir levande

%Nollställer
Universum = Grannar;

%Plottar
[x y z] = ind2sub(size(Universum), find(Universum)); %hittar "koordinater"
scatter3(x, y, z, 'k.'); %plottar koordinater
%----------- kom på hur antalet celler räknas i figuren. nnz = Number of Non Zero matrix elements
xlabel(nnz(Universum));
rotate3d on

%Pausar en stund så att det inte går för snabbt (uppdateringstid)
pause(t)

%Räknar om
Grannar = convn(Universum,o,'same');
end


%Denna kod tog väldigt lång tid att klura ut, men den fungerar!
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

%Gör matris där siffra står för summan av celler runt om dvs en grannmatris
Grannar = convn(Universum,o,'same');

%Skriv in a = 1 för att avbryta eller tryck ctrl+c
a = 0;
txt=['Ctrl+c för att stoppa!'];
disp(txt)

while (a<1)
%Regler 4d (ändra, pga test med grannar visar många grannar)
Grannar(Grannar<17) = [0]; %Om grannar är mindre än 17: Cell dör
Grannar(Grannar>=27 & Grannar<=31) = [1]; %Om grannar är mellan 27 och 31: Cell lever/blir ny cell
Grannar(Grannar>=33) = [0]; %Om grannar är 33 eller mer: Cell dör

%OBS: Om grannar är 20 till 25 ändras inget, dvs inget dör eller skapas
Grannar(Grannar>=17 & Grannar<27 & Universum==0) = [0]; %Ingenting förblir ingenting
Grannar(Grannar>=17 & Grannar<27 & Universum==1) = [1]; %Cell förblir levande

%EXTRA REGLER
%OBS: Om grannar är 31 till 32 ändras inget, dvs inget dör eller skapas
Grannar(Grannar>31 & Grannar<33 & Universum==0) = [0]; %Ingenting förblir ingenting
Grannar(Grannar>31 & Grannar<33 & Universum==1) = [1]; %Cell förblir levande

%Nollställer
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
title(['Värld ' num2str(q) ' '])
end

%----------- kom på hur antalet celler räknas i figuren. nnz = Number of Non Zero matrix elements
xlabel(nnz(Universum));

rotate3d on

%Pausar. OBS! Lång paustid behövs!
pause(t)

%Räknar om
Grannar = convn(Universum,o,'same');
end
end

%5-d också? ;)
