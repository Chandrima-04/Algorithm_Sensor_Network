% fileid = fopen('coord.txt','w');
% for i=1:100
%     x = randi([1 100],1,1);
%     y = randi([1 100],1,1);
%    % B = [x,y];
%    % fprintf(fileid,'x','y');
%     plot(x,y,'*');
%     hold on;
% end

% x = [100,200];
% y = [3,3];
% plot(x,y);
clear;
s = [1 1 1 2 5 3 6 4 7 8 8 8];
t = [2 3 4 5 3 6 4 7 2 6 7 5];
weights = [100 10 10 10 10 20 10 30 50 10 70 10];
G = plot(s,t,weights);
p = plot(G,'EdgeLabel',G.Edges.Weight);