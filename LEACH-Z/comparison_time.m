clear;
%fid = fopen('time_incremental.txt','r');
figure(1);
%e = fscanf(fid,'%f');
e = [0;0;0;0.09;0.10;0.12;0.15];
plot(e);
hold on;

fid1 = fopen('time_gift.txt','r');
d = fscanf(fid1,'%f');
plot(d);
hold on;
title('Plot for comparing time complexities of Incremental and Gift Wrapping Algorithm');

%fclose(fid);
fclose(fid1);


 