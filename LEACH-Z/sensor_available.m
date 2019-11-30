BeconX=500;

BeconY=500; 
%axes(handles.axes1);

gca; hold on;

hbecon=plot(BeconX,BeconY,'s'); 
set(hbecon,'color','red','LineWidth',8);

% Basic part of code is to randomly place the sensor nodes in the given space then connecting each two nodes if the distance between them less than or equal to the communication radius. Kindly check  following Matlab code .

clear;

noOfNodes = 50;
rand('state', 0);
figure(1);
clf;
hold on;
L = 1000;
R = 100; % maximum range;
netXloc = rand(1,noOfNodes)*L;
netYloc = rand(1,noOfNodes)*L;
for i = 1:noOfNodes
plot(netXloc(i), netYloc(i), '.');
text(netXloc(i), netYloc(i), num2str(i));
for j = 1:noOfNodes
distance = sqrt((netXloc(i) - netXloc(j))^2 + (netYloc(i) - netYloc(j))^2);
if distance <= R
matrix(i, j) = 1; % there is a link;
line([netXloc(i) netXloc(j)], [netYloc(i) netYloc(j)], 'LineStyle', ':');
else
matrix(i, j) = inf;
end;
end;
end;
