figure
worldmap('World')
load coast
plotm(lat, long)
geoshow('landareas.shp','FaceColor',[0.5 0.7 0.5])
geoshow('worldrivers.shp','Color', 'blue')
geoshow('worldcities.shp','Marker','.','Color','blue')
states = shaperead('usastatehi', 'UseGeoCoords', true);
symspec = makesymbolspec('Polygon',{'Name', 'Alaska', 'FaceColor', 'red'},{'Name', 'Hawaii', 'FaceColor', 'red'});
geoshow(states, 'SymbolSpec', symspec,'DefaultFaceColor', 'blue','DefaultEdgeColor', 'black');
gridm('on')