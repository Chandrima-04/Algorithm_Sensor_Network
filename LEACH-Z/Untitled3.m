a = rand(10,1);
b = rand(10,1);
fid = fopen('myfile.txt','w');
fprintf(fid,'%f %f\n',[a b]); 
fclose(fid);