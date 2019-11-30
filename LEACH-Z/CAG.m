%dimenion of the field
clear;
xm=100;
ym=100;
%energy_value = 0;
numofnodes = 0;
corrupted  = 0;
energy_value_cag  = 0;
distance = 0;
energy_for_transmission = 0;

% position of the base station/sink
sink.x = 50;
sink.y = 50;

n = 100; %number of nodes
p = 0.1; %election probability of cluster head
E0 = 0.5; %initial energy of the nodes
ETX = 50*0.000000001;
ERX = 50*0.000000001;

%Transmit amplifier types
Efs = 10*0.00000000001;
Emp = 0.0013*0.00000000001;
EDA = 5*0.000000001;

threshold = 20;
d0 = sqrt(Efs/Emp);
%figure(1);
for i=1:n
    S(i).xd = rand(1,1)*xm;
    XR(i) = S(i).xd;
    S(i).yd = rand(1,1)*ym;
    YR(i) = S(i).yd;
    S(i).id = i;
    S(i).type = 1;
    S(i).value = rand*200;
    S(i).clno = 11;
    %plot(S(i).xd , S(i).yd , '*');
    %hold on;
    %plot(50,50,'+');
end

cluster = 0;
for j=1:10
    rand_val = floor(rand*100);
    S(rand_val).clno = cluster;
    S(rand_val).type = 2;
    for i=1:n
        dist = sqrt((S(i).xd-S(rand_val).xd)^2 + (S(i).yd-S(rand_val).yd)^2);
        if (abs(S(i).value - S(rand_val).value) < threshold && S(i).type == 1 && dist<40)
            S(i).type = 0;
            S(i).clno = cluster;
            %plot([S(i).xd S(rand_val).xd],[S(i).yd S(rand_val).yd]);   
        end
    end
    cluster = cluster+1;
end

x1=0;
for i=1:n
    if(S(i).type == 0)
        x1 = x1+1;
    end
end

x= 0;
for j = 1:cluster+1
    for i = 1:n
        if(S(i).clno == j && (S(i).type == 2 || S(i).type == 1))
            x = x+1;
            distance = sqrt((S(i).xd - 50)^2 + (S(i).yd - 50)^2);
            energy_for_transmission = energy_for_transmission + Emp*1000*(distance^4)+(ETX*1000 + Emp*1000*(distance^4));
            energy_value_cag = energy_value_cag + ((ETX+EDA)*1000 + Emp*1000*(distance^4))+(ETX*1000 + Emp*1000*(distance^4));
            break;
        end
    end
end

fileid_2 = fopen('energy_cag.txt' , 'a+');
fprintf(fileid_2,'%f\n',energy_value_cag);
fclose(fileid_2);

num_of_cluster = 100-x1;
fileid_cc = fopen('no_of_c_cag.txt' , 'a+');
fprintf(fileid_cc,'%f\n',num_of_cluster);
fclose(fileid_cc);

%energy_for_clustering  = (num_of_cluster * (ETX + EDA) * 1000);
energy_for_clustering = (energy_value_cag - energy_for_transmission);

fileid_ec = fopen('energy_clustering_cag.txt' , 'a+');
fprintf(fileid_ec,'%f\n',energy_for_clustering);
fclose(fileid_ec);

fileid_et = fopen('energy_transmission_cag.txt' , 'a+');
fprintf(fileid_et,'%f\n',energy_for_transmission);
fclose(fileid_et);


fileid_packets_CAG = fopen('packets_CAG.txt' , 'a+');
fprintf(fileid_packets_CAG,'%f\n',num_of_cluster);
fclose(fileid_packets_CAG);




