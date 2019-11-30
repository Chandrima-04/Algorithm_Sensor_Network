a = rand(10,1);
b = rand(10,1);
fid = fopen('myfile.txt','a+');
fprintf(fid,'%f %f\n',[a b]); 
fclose(fid);