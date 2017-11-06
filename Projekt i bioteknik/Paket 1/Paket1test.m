% %%Paket 1

clear all

load OD_96WP_GroupR.mat

%%Henriks

for x=1:8
    for m=1:12
    plate(1,:)=plate_ods(x,m,:);
    cell{x,m}=plate;
    end
end

figure(1)
hold on

%Timothy+Henrik

for x=1:8
    for m=1:12
    plot(time,cell{x,m});
    end
end
title('Cell population');

xlabel('tid (i timmar))')
ylabel('tid (i timmar))')



