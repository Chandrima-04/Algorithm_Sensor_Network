fileid_2 = fopen('energy_cag.txt' , 'r');
e = fscanf(fileid_2,'%f');
figure(1);
plot(e);
hold on;

fileid1 = fopen('energy_z.txt','r');
d = fscanf(fileid1,'%f');
plot(d);
title('Plot for energy dissipated in CAG and zscore');

fileid_b = fopen('no_of_c_cag.txt' , 'r');
b = fscanf(fileid_b,'%f');
figure(2);
plot(b);
hold on;

fileid_a = fopen('no_of_cluster.txt' , 'r');
a = fscanf(fileid_a,'%f');
plot(a);
hold on;
title('Number of clusters formed in CAG and Z-Score');

fclose(fileid_a);
fclose(fileid_b);

fileid_x = fopen('energy_clustering_cag.txt' , 'r');
x = fscanf(fileid_x,'%f');
figure(3);
plot(x);
hold on;

fileid_y = fopen('energy_clustering_z.txt' , 'r');
y = fscanf(fileid_y,'%f');
plot(y);
hold on;
title('Plot for energy dissipated in clustering');

fclose(fileid_x);
fclose(fileid_y);


fileid_m = fopen('energy_transmission_cag.txt' , 'r');
m = fscanf(fileid_m,'%f');
figure(4);
plot(m);
hold on;

fileid_n = fopen('energy_transmission_z.txt' , 'r');
n = fscanf(fileid_n,'%f');
plot(n);
hold on;
title('Plot for energy dissipated in transmission for CAG and Z Score');

fclose(fileid_m);
fclose(fileid_n);




