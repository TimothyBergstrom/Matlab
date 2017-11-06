%Jämförelse mellan litteratur och celler

%%Timothys kod

clear all

%Antagning: Cellantal = 0.0300 (medelvärde av mängd celler i plate)
%Cell cycle time (expotential growth in rich media) ? min 20-40 for E.coli

%teori
%y(t)=r*timedouble+y0;
%2y0=r*timedouble+y0
%y0=r*timedouble
%r=y0/timedouble


load OD_96WP_GroupR.mat

y0=0.0300;
timedouble=1/0.37; %Henrik: Värde från litteratur bionumbers.org
r=y0/timedouble;
t=0;

for i=1:75
 y(i)=r*t+y0;
 t=t+1;
end
t=1:75;

plot(t,y);
hold on


%cell nummer 39 har högt r

%gör cell
for x=1:8
    for m=1:12
    plate(1,:)=plate_ods(x,m,:);
    cell{x,m}=plate;
    end
end

%får ut MKM värden för varje celltyp
i=1;
for x=1:8
    for m=1:12
    c=polyfit(time,cell{x,m},1);
    sol{i}=c;
    i=i+1;
    end
end

%räknar ut r och y0
for i=1:96
c=sol{i};
r(i)=c(1);
y0(i)=c(2);
end

y0=0.0300;
%plottar cell 36
    for t=1:75
    y(t)=r(39)*t+y0;
    end
    
t=1:75;
plot(t,y);

title('Plot skillnad');
legend('Regular','Celltyp nummer 36');