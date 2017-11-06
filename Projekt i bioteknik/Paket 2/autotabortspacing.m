%%auto ta bort mellanslag
sadasda
fid = fopen('Gen3.txt','wt');
fprintf(fid,'%s',strrep(fileread('Gen3original.txt'),' ',''))
fclose(fid);