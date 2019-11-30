clear;
figure(1);
hold on;
nodes = 40;
basex = 10;
basey = rand(1,1)*10+30;
plot(basex,basey,'*');


%cluster 1
 
    xcord1 = rand(1,10)*10;
    ycord1 = rand(1,10)*10;
    plot(xcord1,ycord1,'.');
    for i=1:10
        x = xcord1(i);
        y = ycord1(i);
        distance = sqrt((x-basex)^2 + (y-basey)^2);
        minimum = 1000;
        if distance<minimum 
            minimum = distance;
            headx1 = x;
            heady1 = y;
        end
    end
    plot([headx1,basex], [heady1,basey]);
    for i=1:10
        plot([xcord1(i),headx1],[ycord1(i),heady1]);
    end;
    dist = 0;
    for i=1:10
        dist = dist+sqrt((xcord1(i)-basex)^2 + (ycord1(i)-basey)^2);
    end
    head_dist(1) = minimum;
    node_dist(1) = dist;
    
    
        
    
%cluster 2

    xcord2 = rand(1,10)*10 + 10;
    ycord2 = rand(1,10)*10;
    plot(xcord2,ycord2,'.');

    for i=1:10
        x = xcord2(i);
        y = ycord2(i);
        distance = sqrt((x-basex)^2 + (y-basey)^2);
        minimum = 1000;
        if distance<minimum 
            minimum = distance;
            headx2 = x;
            heady2 = y;
        end
    end
    plot([headx2,basex], [heady2,basey]);
    for i=1:10
        plot([xcord2(i),headx2],[ycord2(i),heady2]);
    end;
    
    dist = 0;
    for i=1:10
        dist = dist+sqrt((xcord2(i)-basex)^2 + (ycord2(i)-basey)^2);
    end
    head_dist(2) = minimum;
    node_dist(2) = dist;
    
    
    
%cluster 3
    xcord3 = rand(1,10)*10;
    ycord3 = rand(1,10)*10 + 10;
    plot(xcord3,ycord3,'.');

    for i=1:10
        x = xcord3(i);
        y = ycord3(i);
        distance = sqrt((x-basex)^2 + (y-basey)^2);
        minimum = 1000;
        if distance<minimum 
            minimum = distance;
            headx3 = x;
            heady3 = y;
        end
    end
    plot([headx3,basex], [heady3,basey]);
    for i=1:10
        plot([xcord3(i),headx3],[ycord3(i),heady3]);
    end;
    dist = 0;
    for i=1:10
        dist = dist+sqrt((xcord3(i)-basex)^2 + (ycord3(i)-basey)^2);
    end
    head_dist(3) = minimum;
    node_dist(3) = dist;
    
    
    
%cluster 4
    xcord4 = rand(1,10)*10 + 10;
    ycord4 = rand(1,10)*10 + 10;
    plot(xcord4,ycord4,'.');
    
    for i=1:10
        x = xcord4(i);
        y = ycord4(i);
        distance = sqrt((x-basex)^2 + (y-basey)^2);
        minimum = 1000;
        if distance<minimum 
            minimum = distance;
            headx4 = x;
            heady4 = y;
        end
    end
     plot([headx4,basex], [heady4,basey]);
     for i=1:10
        plot([xcord4(i),headx4],[ycord4(i),heady4]);
    end;
    
    dist = 0;
    for i=1:10
        dist = dist+sqrt((xcord4(i)-basex)^2 + (ycord4(i)-basey)^2);
    end
    head_dist(4) = minimum;
    node_dist(4) = dist;
    
    plot(headx1,heady1,'*');
    plot(headx2,heady2,'*');
    plot(headx3,heady3,'*');
    plot(headx4,heady4,'*');

    figure(2);
    plot(head_dist);
    hold on;
    plot(node_dist);
