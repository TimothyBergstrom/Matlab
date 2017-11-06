%%Ändra och stäng allt

close all
clear all
clc

%% Ladda gen genom att använda genbank
%endoXylanase= getgenbank('AJ508403'); % AJ508403 = endo-xylanase locus
%sequence = endoXylanase.Sequence;

% betaXylosidase= getgenbank('CM001403'); % CM001403 = beta-xylosidase locus 
% sequence = betaXylosidase.Sequence;

% alphaArabino = getgenbank('AJ508406'); % AJ508406 = alpha-arabinofuranodidase locus
% sequence = alphaArbabino.Sequence;


%% Ladda gen genom att använda kodonoptimerade mRNA till cDNA sekvenser

clear all
close all
clc

disp('Vilken enzym/gen?')
disp('1:endo-xylanase')
disp('2:beta-xylosidase')
disp('3:alpha-arabinofuranodidase')
disp('4:TAF10')

choice=5;

while choice<1 || choice>4
choice=input('Enzymnummer = ')
    if choice==1
       namn='Gen1.txt'
    elseif choice==2
       namn='Gen2.txt'
    elseif choice==3
       namn='Gen3.txt'
    elseif choice==4
       namn='Gen4.txt'
    end
end

%öppnar generna för enzym 1
filid = fopen(namn,'rt');
%läser in texten
text = textscan(filid,'%s','Delimiter','\n');
%gör om cell till char
sequence = char(text{1});


%% Hitta alla möjliga forward primers med rätt längd (just nu 20baser)

N = length(sequence) % längd av gensekvens
M = 20  % önskad längd på primer
%M = input('längd på primers = '); %val av längd på primer
index = repmat((0:N-M)',1,M)+repmat(1:M,N-M+1,1); 
% repmat skapar matris med antal rader = längd på gensekvens-(M-1) och antal kolonner 
% = längd på primer för att skapa alla möjliga primer
fwdprimerlist = sequence(index); 
% Sätter in gensekvens i tidigare skapad matris för att få fram sekvens på
% möjliga primers
 
for i = N-(M-1):-1:1  % Skapar loop för alla möjliga primer och använder MATLAB 
% funktonen oligoprop för att få ut information om alla möjliga primers 
    fwdprimerprops(i) = oligoprop(fwdprimerlist(i,:));
end
 
%% Hitta alla reversed primers med rätt längd (just nu 20 baser)
 
comp_sequence = seqcomplement(sequence); % Tar fram komplementära sekvensen till gensekvens
revprimerlist = seqreverse(comp_sequence(index)); % Tar fram alla möjliga reversed primers med längd = 20
 
for i = N-(M-1):-1:1 % Skapar loop för alla möjliga reversed primers och använder MATLAB 
% funktonen oligoprop för att få ut information om alla möjliga primers 
    revprimerprops(i) = oligoprop(revprimerlist(i,:));
end
 
%% Sortering av primers utifrån GC innehåll
 
fwdgc = [fwdprimerprops.GC]'; % Beräknar antal GC för varje forward primer
revgc = [revprimerprops.GC]'; % Beräknar antal GC för varje reversed primer
 
% Sorterar bra/dåliga primers utifrån GC innehåll
bad_fwdprimers_gc = fwdgc < 45 | fwdgc > 55; % Bra forward primers har GC mellan 45% till 55% --> resten är dåliga
bad_revprimers_gc = revgc < 45 | revgc > 55; % Bra reversed primers har GC mellan 45% till 55% --> resten är dåliga
 
%% Sortering av primer utifrån deras smälttemperatur, Tm
 
fwdtm = cell2mat({fwdprimerprops.Tm}'); % Beräknar Tm för varje forward primer
revtm = cell2mat({revprimerprops.Tm}'); % Beräknar Tm för varje reversed primer 
 
% Sorterar bra/dåliga primers utifrån smälttemperatur
bad_fwdprimers_tm = fwdtm(:,5) < 50 | fwdtm(:,5) > 60; % Bra forward primers har Tm mellan 50°C och 60°C --> resten är dåliga
bad_revprimers_tm = revtm(:,5) < 50 | revtm(:,5) > 60; % Bra reversed primers har Tm mellan 50°C och 60°C --> resten är dåliga

 
%% Hitta primers som själv-dimeriserar (self-dimerization) och skapar hårnålar (hairpins)
 
bad_fwdprimers_dimers  = ~cellfun('isempty',{fwdprimerprops.Dimers}');   % Tar ut de forward primers som själv dimeriserar, 1=själv dimieriserar, 0 gör inte
bad_fwdprimers_hairpin = ~cellfun('isempty',{fwdprimerprops.Hairpins}'); % Tar ut de forward primers som skapar hårnålar, 1=skapar hårnålar, 0 gör inte
bad_revprimers_dimers  = ~cellfun('isempty',{revprimerprops.Dimers}');   % Tar ut de reversed primers som själv dimeriserar, 1=själv dimieriserar, 0 gör inte
bad_revprimers_hairpin = ~cellfun('isempty',{revprimerprops.Hairpins}'); % Tar ut de reversed primers som skapar hårnålar, 1=skapar hårnålar, 0 gör inte
 
%% Hitta primers som inte har GC clamp vid 3' änden
 
bad_fwdprimers_clamp = lower(fwdprimerlist(:,end)) == 'a' | lower(fwdprimerlist(:,end)) == 't'; % Tar ut de forward primers som har a eller t vid 3' änden
bad_revprimers_clamp = lower(revprimerlist(:,end)) == 'a' | lower(revprimerlist(:,end)) == 't'; % Tar ut de reversed primers som har a eller t vid 3' änden


%% Hittar alla primers med en GC
% Det är gynnsamt om primern binder start på 3' änden i PCR. (Alla sekvenser är från 5’ till 3’)
% Detta hittar alla primers som inte har G or C i ändan. 

bad_fwdprimers_clamp = lower(fwdprimerlist(:,end)) == 'a' | lower(fwdprimerlist(:,end)) == 't'; 
bad_revprimers_clamp = lower(revprimerlist(:,end)) == 'a' | lower(revprimerlist(:,end)) == 't'; 
 

%Man kan tänka på nukleotid repeats, men de struntar vi i!
 
%% Sorterar alla primers som uppfyller alla kraven
%De primers som inte uppfyller kraven går hamnar i en structfil.
%Blå = bra primer
%Röd = dålig primer
 
%Dåliga forwardprimers
bad_fwdprimers = [bad_fwdprimers_gc,bad_fwdprimers_tm,... 
                  bad_fwdprimers_dimers,bad_fwdprimers_hairpin,...
                  bad_fwdprimers_clamp];

%Dåliga reverseprimers
bad_revprimers = [bad_revprimers_gc,bad_revprimers_tm,... 
                  bad_revprimers_dimers,bad_revprimers_hairpin,...
                  bad_revprimers_clamp];             
                 
%bra forwardprimers är de som ej ligger i struct med dåliga primers              
good_fwdpos = find(all(~bad_fwdprimers,2));
good_fwdprimers = fwdprimerlist(good_fwdpos,:);
good_fwdprop = fwdprimerprops(good_fwdpos);
N_good_fwdprimers = numel(good_fwdprop)

%bra forwardprimers är de som ej ligger i struct med dåliga primers              
good_revpos = find(all(~bad_revprimers,2));
good_revprimers = revprimerlist(good_revpos,:);
good_revprop = revprimerprops(good_revpos);
N_good_revprimers = numel(good_revprop)
 
figure
imagesc([bad_fwdprimers any(bad_fwdprimers,2)]);
title('Filtering candidate forward primers');
ylabel('Primer location');
xlabel('Criteria');
ax = gca;
ax.XTickLabel = char({'%GC','Tm','dimers','hairpin','GC clamp','all'});
ax.Position = [0.1 0.11 .7 0.81];
annotation(gcf,'textbox','String','Good primers','Color','w',...
  'Position',[0.81 0.8 0.17 0.06],'BackgroundColor',[0 0 0.6275]);
annotation(gcf,'textbox','String','Bad primers','Color','w',...
  'Position',[0.81 0.72 0.17 0.06],'BackgroundColor',[0.502 0.502 0]);

%% Kolla efter kross dimerisering
 
scr_mat = [-1,-1,-1,1;-1,-1,1,-1;-1,1,-1,-1;1,-1,-1,-1;]; 
scr = zeros(N_good_fwdprimers,N_good_revprimers); % Skapa matris med bra primers
for i = 1:N_good_fwdprimers  % Skapar loop med alla bra forward primers
    for j = 1:N_good_revprimers % Skapar loop med alla bra reversed primers
        if good_fwdpos(i) < good_revpos(j)  
            scr(i,j) = swalign(good_fwdprimers(i,:), good_revprimers(j,:), ... % använd swalign funktion för att se om forward primer binder till reversed, testar mot alla
                              'SCORINGMATRIX',scr_mat,'GAPOPEN',5,'ALPHA','NT');
        else
            scr(i,j) = 13;
        end
    end
end
 
% Plotta resultatet, mörkblå indikerar att de inte kross dimeriserar
figure
imagesc(scr)
title('Cross dimerization scores')
xlabel('Candidate reverse primers')
ylabel('Candidate forward primers')
colorbar
 
%%
% Low scoring primer pairs are identified a logical one in an indicator matrix.
pairedprimers = scr<=3; 
%% Visualisering av poteintialla primerpar (reverse och forward)
%Varje punkt i plotten repressenterar ett primerpar som kan fungera i PCR som ej dimersieras
% Man kan också visualisera detta genom att se på sekvenserna
 
[f,r] = find(pairedprimers);
figure
plot(good_revpos(r),good_fwdpos(f),'r.','markersize',10)
axis([1 N 1 N])
title('Primer selection graph')
xlabel('Reverse primer positions')
ylabel('Forward primer positions')
 
%% Längd på amplifiering av DNA i PCR mha primer
% Vi vill hitta primers som gör amplifierat DNA mellan 100 till 150 baspar
%I PCR processen gör forward primern en sträng från cDNA:t och reverseprimern en annan sträng
%De bildade två strängarna som ska mötas och skapa amplifierat DNA som är
%en viss längd
%Längden på primern M måste tas hänsyn till.

%hittar potentiella par
pairs = find(good_fwdpos(f) & good_revpos(r));
dist = (good_fwdpos(f(pairs)).^2 + (good_revpos(r(pairs)).^2));
[dist,h] = sort(dist);
pairs = pairs(h);

%markerar de bra paren
hold on
plot(good_revpos(r(pairs)),good_fwdpos(f(pairs)),'b.','markersize',10)
%% Ta fram de bästa primer paren 

%Räknar antalet primerpar med amplificationlength 100-150 bp
ticker=1;

%Räknar antalet primerpar med amplificationlength som inte är 100-150 bp
skip=1;

primeramp=good_revpos(r(pairs(:)))-good_fwdpos(f(pairs(:)));

Primers = sprintf('Fwd/Rev Primers      Start End   %%GC   mT   Length\n\n'); % Använd funktionen sprintf för att ta fram de bästa paren, i vårt fall top 3
for i = 1:length(pairs)-1  % 1-3 för top 3 primer paren
    fwd = f(pairs(i))
    rev = r(pairs(i));
    distans=good_revpos(rev) - good_fwdpos(fwd) %Sorterar par beroende på amplificationslängd
    if (distans>=100) && (distans<=150)
    Primers = sprintf('%s%-21s%-6d%-6d%-4.4g%-4.4g\n%-21s%-6d%-6d%-4.4g%-7.4g%-6d\n\n', ...
    Primers, good_fwdprimers(fwd,:),good_fwdpos(fwd),good_fwdpos(fwd)+M-1,good_fwdprop(fwd).GC,good_fwdprop(fwd).Tm(5), ...
             good_revprimers(rev,:),good_revpos(rev)+M-1,good_revpos(rev),good_revprop(rev).GC,good_revprop(rev).Tm(5), ...
             good_revpos(rev) - good_fwdpos(fwd));
         
    %Tar  
    Forwardvalues{ticker}=[good_fwdpos(fwd),(good_fwdpos(fwd)+M-1),good_fwdprop(fwd).GC,good_fwdprop(fwd).Tm(5)];
    Forwardsequence{ticker}=good_fwdprimers(fwd,:);
    Reversevalues{ticker}=[good_revpos(rev)+M-1,good_revpos(rev),good_revprop(rev).GC,good_revprop(rev).Tm(5)];
    Reversesequence{ticker}=good_revprimers(rev,:);
    Length{ticker}=good_revpos(rev) - good_fwdpos(fwd);
    Combinedcell{ticker}={Forwardvalues{ticker},Forwardsequence{ticker},Reversevalues{ticker},Reversesequence{ticker},Length{ticker}};
    
    ticker=ticker+1;
    else
    skipped(skip)=1;
    skip=skip+1;
    end
    %if ticker==4
    %   break
    %end
         
end
disp(Primers) % visa top tre primer par
summahoppat=sum(skipped); %debugging tool, ser antalet primerpar som skippas


%% Randomisering av vilka primerpar som tas ut (extrafunktion)

%Detta är en funktion för att randomisera 3 primpar från alla potentiella primpar

for i=1:3
random(i)=randi([1 ticker]);
end
random

%Då primerparen ska alltid vara samma för varje gång, tas tre värden som
%randomiserades: 2, 25 och 45

Primers = sprintf('Fwd/Rev Primers      Start End   %%GC   mT   Length\n\n');
for i=random
    Primerpar=Combinedcell{i};
    Primerparforward=Primerpar{1};
    Primerparreverse=Primerpar{3};
    Primers = sprintf('%s%-21s%-6d%-6d%-4.4g%-4.4g\n%-21s%-6d%-6d%-4.4g%-7.4g%-6d\n\n', ...
    Primers, Primerpar{2},Primerparforward(1),Primerparforward(2),Primerparforward(3),Primerparforward(4), ...
             Primerpar{4},Primerparreverse(1),Primerparreverse(2),Primerparreverse(3),Primerparreverse(4), ...
             Primerpar{5});
end
disp(Primers) 
