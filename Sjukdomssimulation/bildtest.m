[Pop,map] = imread('World_population_density_1994changed.png');
image(Pop)
Popmatris=[];
itt=0;
for row=1:3977
    for column=1:6693
        for color=1:3
            pixel(color)=Pop(row,column,color);
        end
        if pixel==[232 232 232]
            Popmatris(row,column)=2;
        elseif pixel==[168 255 168]
            Popmatris(row,column)=5;
        elseif pixel==[255 115 0]
            Popmatris(row,column)=20;
        elseif pixel==[255 0 0]
            Popmatris(row,column)=50;
        elseif pixel==[204 0 0]
            Popmatris(row,column)=250;
        elseif pixel==[255 0 255]
            Popmatris(row,column)=500;
        else
            Popmatris(row,column)=0;
        end
    end
    itt=itt+1
end