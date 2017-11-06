%Gen1 
%endo�xylanase

clear all
close all
clc

%�ppnar generna f�r enzym 1
filid = fopen('Gen1.txt','rt');
%l�ser in texten
text = textscan(filid,'%s','Delimiter','\n');
%g�r om cell till char
sekvens = char(text{1});


%__________________________
%Skapar primers, forward

%source https://se.mathworks.com/help/bioinfo/examples/exploring-primer-design.html?requestedDomain=se.mathworks.com


%BARA F�R 30 just nu! Fixa koden!

gen = length(sekvens); %L�ngd av genen

for primer = 18:20 %storlek p� primer 18 till 30
index = repmat((0:gen-primer)',1,primer)+repmat(1:primer,gen-primer+1,1);
forwardprimerlista = sekvens(index);

    for i = gen-19:-1:1 % reverse order to pre-allocate structure
    forwardprimer(i) = oligoprop(forwardprimerlista(i,:));
    end

end

gen
primer


%__________________________
%Skapar primers, reverse


sekvensreverse = seqcomplement(sekvens);
reverseprimerlista = seqreverse(sekvensreverse(index));

for i = gen-19:-1:1 % reverse order to preallocate structure
    reverseprimer(i) = oligoprop(reverseprimerlista(i,:));
end


%___________________
%filtrering med avseende p� GC

forwardgc = [forwardprimer.GC]';
reversegc = [reverseprimer.GC]';

bad_fwdprimers_gc = forwardgc < 45 | forwardgc > 55;
bad_revprimers_gc = reversegc < 45 | reversegc > 55;

%deletar de d�liga
tick=0;
for i=1:length(forwardgc)
    if bad_fwdprimers_gc(i) == 0
       braforwardgc(i-tick)=forwardprimer(i);
    end
    tick=tick+1;
end
        
