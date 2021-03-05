function ind(n1, n2, val)
% Adds the stamp of an inductor with a value of "val" (Henrys)
% connected between nodes n1 and n2 to the matrices in
% circuit representation.
%
%                 val
%      n1 O-----@@@@@@-----O n2      where L=val (henry)
%              IL ---->
%---------------------------------------------------------------

global G C b

d = size(G,1); % current size of the MNA
xr = d+1;      % new (extera)row/column

% Using an index bigger than the current size, Matlab  
...automaticallyincreases the size of the matrix:
    
G(xr,xr) = 0; % add new row/column
C(xr,xr) = 0;
b(xr,1) = 0;
 
if (n1 ~= 0)
    G(n1,xr) = 1;
    G(xr,n1) = 1;
end

if (n2 ~= 0)
    G(n2,xr) = -1;
    G(xr,n2) = -1;
end
C(xr,xr) = -1*val;
% 
% 
% % The body of the function will go here!
% global L   %define global variable
% 
% if (n1 ~= 0)
%     L(n1,n1) = L(n1,n1) + 1/(val);
% end
% 
% if (n2 ~= 0)
%     L(n2,n2) = L(n2,n2) + 1/(val);
% end
% 
% if (n1 ~= 0) && (n2 ~= 0)
%     L(n1,n2) = L(n1,n2) - 1/(val);
%     L(n2,n1) = L(n2,n1) - 1/(val);
end

