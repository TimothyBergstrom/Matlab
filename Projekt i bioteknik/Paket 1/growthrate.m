
%%Timothys kod
clear all
close all
load OD_96WP_GroupR.mat

%A=[celltyp 1 celltyp 2.... celltyp 12; celltyp 13 celltyp 14.... osv]


%gör cell
for x=1:8
    for m=1:12
    plate(1,:)=plate_ods(x,m,:);
    cell{x,m}=plate;
    end
end

%får ut r värden för varje celltyp

i=1;
for x=1:8
    for m=1:12
        vektor=cell{x,m};
        for q=1:225
        r(q)=(log2(vektor(q+1))-log2(vektor(q)))/(time(q+1)-time(q));
        end
        rspara{i}=r;
        i=i+1;
    end
end


%plottar tillväxt r (derivata av tillväxt)
figure(1)
hold on
title('r plotting')

for i=1:96
    vektor=rspara{i};
    plot(time(1:225),vektor);
end


%skapar MKM av r värden och plottar
figure(2)
hold on
for i=1:96
    vektor=rspara{i};
    c=polyfit(time(1:225),vektor,1);
    cspara{i}=c;
    val=polyval(c,time(1:225));
    plot(time(1:225),val);
end
title('MKM av r värden');
    
%hittar maximala r värden för celler
i=1;
for q=1:96
vektor=rspara{q};
Maxr(i) = max(vektor);
i=i+1;
end

%hittar maximala r värden för celler i MKM
for q=1:96
c=cspara{q};
c=c(2);
AMKM(q)=c;
end
AMKM = vec2mat(AMKM,12);


%Skapar matris med max r
A = vec2mat(Maxr,12);
i=1;
for x=1:8
    for m=1:12
    A(x,m)=r(i);
    i=i+1;
    end
end

%%Henriks ide med hot. Vit = högst r, Svart = lågt r
figure(4)
colormap(hot)
imagesc(A)
colorbar
title('Colormap m.a.p maxr')

%%Timothy, med MKM av r
figure(5)
colormap(hot)
imagesc(AMKM)
colorbar
title('Colormap m.a.p MKM')

%____________________________

%celler: 4,3 4,6 5,6 3,12 7,12 =12 24 30 36 84 innan
figure()
hold on
for x=1:8
    for m=1:12
    plot(time,cell{x,m});
    end
end
title('Cell population');
xlabel('tid (i timmar))')
ylabel('tid (i timmar))')

