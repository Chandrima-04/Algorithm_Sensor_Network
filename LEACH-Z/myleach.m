%dimenion of the field
clear;
xm=100;
ym=100;
energy_value = 0;
numofnodes = 0;
corrupted  = 0;
energy_value_z  = 0;

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

%Data Aggregation energy
EDA = 5*0.000000001;

%Values for heterogeneity
m=0.1;
a=1;

rmax = 1000; %Maximum number of rounds


d0 = sqrt(Efs/Emp);

%Creation of random sensor network
figure(1);
for i=1:n
    S(i).xd = rand(1,1)*xm;
    XR(i) = S(i).xd;
    S(i).yd = rand(1,1)*ym;
    YR(i) = S(i).yd;
    S(i).G = 0; %initially no node belongs to any group
    %Initially there are no cluster heads
    S(i).type = 'N';
    
    temp_rnd0 = i;
    
    %Random election of normal nodes
    if (temp_rnd0>=m*n+1)
        S(i).E = E0;
        S(i).ENERGY = 0;
        plot(S(i).xd,S(i).yd,'o');
        hold on;
    end
    
    %Random election of advanced nodes
    if(temp_rnd0<m*n+1)
        S(i).E = E0;
        S(i).ENERGY = 1;
        plot(S(i).xd,S(i).yd,'+');
        hold on;
    end
end

S(n+1).xd = sink.x;
S(n+1).yd = sink.y;

plot(S(n+1).xd,S(n+1).yd,'x');

%First iteration
figure(1);

%counter for cluster heads
countch = 0;
rcountch = 0; %CH counter per round
cluster = 1;

countch;
rcountch = rcountch+countch;
flag_first_dead = 0;

for r=0:1:rmax
    
    %operation of epoch
    if(mod(r,round(1/p)) == 0)
        for i=1:n
            S(i).G = 0;
            S(i).c1 = 0;
        end
    end
end
hold off;

dead = 0; %nodes
dead_a = 0; %advanced nodes
dead_n = 0; %normal nodes

packets_to_BS = 0; 
packets_to_CH = 0;

%packets per round
packets_to_CH(r+1) = 0;
packets_to_BS(r+1) = 0;

figure(1);

for i=1:n
    %checking whether a dead node
    if(S(i).E<=0)
        plot(S(i).xd,S(i).yd,'red .');
        dead = dead+1;
        if(S(i).ENERGY==1)
            dead_a = dead_a+1;
        end
        if(S(i).ENERGY ==0)
            dead_n = dead_n+1;
        end
        hold on;
    end


    if S(i).E>0
        S(i).type = 'N';
        if (S(i).ENERGY == 0)
            plot(S(i).xd,S(i).yd,'o');
        end
        if(S(i).ENERGY==1)
            plot(S(i).xd,S(i).yd,'+');
        end
        hold on;
    end
end

stats(r+1).DEAD  = dead;
DEAD(r+1) = dead;

if r+1==1095
    S(i).E = 0;
end

if(dead == 1)
    if(flag_first_dead == 0)
        first_dead = 1;
        flag_first_dead  = 1;
    end
end

countch = 0;
cluster  = 1;
clno = 1;
for i=1:n
    if(S(i).E>0)
        temp_rand = rand;
        if((S(i).G)<=0)
            %Election of cluster heads
            if(temp_rand <= (p/(1-p*mod(r,round(1/p)))))
                countch = countch+1;
                %packets_to_BS = packets_to_BS+1;
                %packets_to_BS(r+1) = packets_to_BS;
                
                S(i).type = 'C';
                S(i).G = round(1/p)-1;
                C(cluster).xd = S(i).xd;
                C(cluster).yd = S(i).yd;
                C(cluster).clusterno = clno;
                clno = clno+1;
                plot(S(i).xd,S(i).yd,'*');
                distance = sqrt((S(i).xd - S(n+1).xd)^2 + (S(i).yd-S(n+1).yd)^2);
                C(cluster).distance = distance;
                C(cluster).id = i;
                X(cluster) = S(i).xd;
                Y(cluster) = S(i).yd;
                cluster  = cluster+1;
                
                %Calculation of energy dissipated
                distance;
                if(distance>d0)
                    S(i).E = S(i).E - ((ETX+EDA)*1000 + Emp*1000*(distance*distance*distance*distance));
                    energy_value = energy_value+((ETX+EDA)*1000 + Emp*1000*(distance*distance*distance*distance));
                end
                if(distance<=d0)
                    S(i).E = S(i).E - ((ETX+EDA)*1000 + Emp*1000*(distance*distance));
                    energy_value = energy_value + ((ETX+EDA)*1000 + Emp*1000*(distance*distance));
                end
            end
        end
    end
end

stats(r+1).CLUSTERHEADS = cluster-1;
CLUSTERS(r+1) = cluster-1;

%Election of associated cluster heads for normal nodes

for i=1:n
    if(S(i).type=='N' & S(i).E>0)
        if(cluster-1>=1)
            min_dis = sqrt((S(i).xd-S(n+1).xd)^2 + (S(i).yd-S(n+1).yd)^2);
            min_dis_cluster = 1;
            for c=1:1:cluster-1
                temp=min(min_dis,sqrt((S(i).xd-C(c).xd)^2 + (S(i).yd-C(c).yd)^2));
                if(temp<min_dis);
                    min_dis = temp;
                    min_dis_cluster = c;
                end  
            end
            
            
            %Energy dissipated by associated cluster heads
            min_dis;
            if(min_dis>d0)
                S(i).E = S(i).E - (ETX*1000 + Emp*1000*(min_dis^4));
                energy_value = energy_value + (ETX*1000 + Emp*1000*(min_dis^4));
            else
                S(i).E = S(i).E - (ETX*1000 + Emp*1000*(min_dis^2));
                energy_value = energy_value + (ETX*1000 + Emp*1000*(min_dis^2));
            end
            
            %Energy dissipated
            if(min_dis>0)
                S(C(min_dis_cluster).id).E = S(C(min_dis_cluster).id).E - ((ERX-EDA)*1000);
                packets_to_CH(r+1) = n-dead-cluster+1;
            end
            S(i).min_dis = min_dis;
            S(i).min_dis_cluster = min_dis_cluster;
        end
    end
end

hold on;
countch;
rcountch = rcountch+countch;


j = 1;
for i=1:n
    mydist = 1000;
    for c=1:cluster-1
        d = sqrt((S(i).xd-C(c).xd)^2 + (S(i).yd-C(c).yd)^2)
        if( d<mydist)
            mydist = d;
            e(j).xd = C(c).xd;
            e(j).yd = C(c).yd;
            e(j).clusterno = C(c).clusterno;
        end
    end
    plot([S(i).xd e(i).xd],[S(i).yd e(i).yd]);
    j = j+1;
end




%Energy dissipation through Z-Score technique
randval = zeros(cluster-1,100);
j=1;
for index=1:cluster-1
    for i=1:n
        if e(i).clusterno == index
            randval(index,j) = rand*500+1; 
            %distance to be kept in an array in order to compute the energy
            %dissipated
            
            j = j+1;
        end
    end
    j=1;
end

j = 1;
for index = 1:cluster-1
    for i = 1:n
        if randval(index,i) == 0
            break;
        else
            numofnodes = numofnodes+1;
        end
    end
    
   mymatrix = zeros(1,numofnodes);
   for i = 1:n
        if randval(index,i) == 0
            break;
        else
            mymatrix(1,j) = randval(index,i);
            j = j+1;
        end
    end
    meanval = mean(mymatrix);
    std_dev = std(mymatrix);
    for i=1:numofnodes
        zscore = abs(mymatrix(1,i) - meanval)/std_dev;
        if zscore>1
            corrupted = corrupted + 1;
        end
    end
    total_packets_sent = 1+corrupted;
    totaldistance = C(index).distance * total_packets_sent;
    
    energy_value_z = energy_value_z + ((ETX+EDA)*1000 + Emp*1000*(totaldistance^2))+(ETX*1000 + Emp*1000*(totaldistance^2));
    
    corrupted = 0;
    j = 1;
    numofnodes = 0;
end

fileid1 = fopen('energy_z.txt' , 'a+');
fprintf(fileid1,'%f\n',energy_value_z);
fclose(fileid1);

fileid = fopen('energy.txt' , 'a+'); %For each round of leach, the energy dissipated is stored in a file.
fprintf(fileid,'%f\n',energy_value);
fclose(fileid);


fileid_c = fopen('no_of_cluster.txt' , 'a+');
fprintf(fileid_c,'%f\n',cluster);
fclose(fileid_c);

energy_for_clustering  = (cluster * (ETX + EDA) * 1000);
energy_for_transmission = energy_value_z - energy_for_clustering;

fileid_ec_z = fopen('energy_clustering_z.txt' , 'a+');
fprintf(fileid_ec_z,'%f\n',energy_for_clustering);
fclose(fileid_ec_z);

fileid_et_z = fopen('energy_transmission_z.txt' , 'a+');
fprintf(fileid_et_z,'%f\n',energy_for_transmission);
fclose(fileid_et_z);

fileid_packets = fopen('packets_sent_z' , 'a+');
fprintf(fileid_packets,'%f\n',total_packets_sent);
fclose(fileid_packets);








    
    
    
            
    

       
    



