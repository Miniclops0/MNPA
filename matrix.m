% ELEC4700
% Student Name: Connor Warden 
% Student#: 101078296  
% Lab1-Q1
%--------------------------------------------------------------------------
clc; close all;  clear all;  %initialization of the matlab environment
NrNodes = 5;

global G C b L; %define global variables

G = zeros(NrNodes,NrNodes); 
C = zeros(NrNodes,NrNodes);
b = zeros(NrNodes,1);
L = zeros(NrNodes,NrNodes);

%--------------------------------------------------------------------------
% List of the components (netlist):
%--------------------------------------------------------------------------
R1 = 1;  %Ohms
R2 = 2;  %Ohms
R3 = 10;  %Ohms
R4 = 0.1;  %Ohms
Ro = 1000;  %Ohms
C1 = 0.25;  %Farads
L1 = 0.2;  %Henry
alpha = 100;

% DC CASE 2B
Vout = zeros(21,1);
v3 = zeros(21,1);
%
% AC CASE 2C
% Vout = zeros(101,1);
% v3 = zeros(101,1);
vin_a = zeros(21,1);
for i = 1:21
    [vin] = dc_sweep(i);
    G = zeros(NrNodes,NrNodes); 
    C = zeros(NrNodes,NrNodes);
    b = zeros(NrNodes,1);
    L = zeros(NrNodes,NrNodes);
    vol(1,0, vin)
    res(1,2,R1)
    cap(1,2,C1)
    res(2,0,R2)
    ind(2,3,L1)
    res(3,0,R3)
    res(4,5,R4)
    res(5,0,Ro)
    vcvs(4,0,3,0,alpha/R3)
    % The following 8 lines are for AC case 2C
%     for n=1:100
%         w = n;
%         s = 1i*w;
%         A =  G+C*s;  %Enter A here! 
%         X = A\b;  % The operator "\" is an efficient way to solve AX=b.
%         Vout(n,1) = X(5);  
%         v3(n,1) = X(3);                         
%     end

   % The following 4 lines are for the DC CASE 2B
    A =  G;  %Enter A here! 
    X = A\b;  % The operator "\" is an efficient way to solve AX=b.
    Vout(i,1) = X(5);
    v3(i,1) = X(3);

    vin_a(i,1) = vin;
end

% for n=1:100
%     w = n;
%     s = 1i*w;
%     A =  G+C*s;  %Enter A here! 
%     X = A\b;  % The operator "\" is an efficient way to solve AX=b.
%     Vout(n,1) = X(5);  % Here, you are collecting the response
%                               ... at the output node for different
%                               ...  frequency in an array named (Vout)!
% end


%%FOR DC CASE 2B
interval = linspace(-10,10,21)';

%FOR AC CASE 2C
%interval = linspace(0,100,101)';

figure(1)
plot(interval, Vout)
hold on
plot(interval, v3)
legend({'Vout','V3'},'Location','northwest')

%FOR AC CASE 2C, GAIN OF CIRCUIT WITH REPECT TO w
figure(2)
plot(interval, 20*log(Vout/vin_a));
title("Vo/Vi (dB)")
xlabel("w")
ylabel("Gain")

% I just added all of part 2D down here, seemed easier that way

Vout = zeros(1001,1);
vin_a = zeros(1001,1);
c = zeros(1001,1);
for i = 1:1001
    C1 = 0.05.*randn + 0.25;
    vin = 10; % set Vin as 10 for this part
    G = zeros(NrNodes,NrNodes); 
    C = zeros(NrNodes,NrNodes);
    b = zeros(NrNodes,1);
    L = zeros(NrNodes,NrNodes);
    vol(1,0, vin)
    res(1,2,R1)
    cap(1,2,C1)
    res(2,0,R1)
    ind(2,3,L1)
    res(3,0,R3)
    res(4,5,R4)
    res(5,0,Ro)
    vcvs(4,0,3,0,alpha/R3)
    % The following 8 lines are for AC case 2C
    w = pi;
    s = 1i*w;
    A =  G+C*s;  %Enter A here! 
    X = A\b;  % The operator "\" is an efficient way to solve AX=b.
    Vout(i,1) = X(5);                          

%    % The following 4 lines are for the DC CASE 2B
%     A =  G;  %Enter A here! 
%     X = A\b;  % The operator "\" is an efficient way to solve AX=b.
%     Vout(i,1) = X(5);
%     v3(i,1) = X(3);

    c(i,:) = C1;

end

gain = 20*log(Vout./vin);
figure(3)
histogram(c)
figure(4)
histogram(abs(gain))


% G = [G1 -G1 0 0 0 1 0 0;
%     -G1 G1+G2 0 0 0 0 1 0;
%     0 0 G3 0 0 0 -1 0;
%     0 0 0 G4 -G4 0 0 1;
%     0 0 0 -G4 G4+G5 0 0 0;
%     1 0 0 0 0 0 0 0;
%     0 1 -1 0 0 0 0 0;
%     0 0 -alpha*G3 1 0 0 0 0];
% C = [C1 -C1 0 0 0 0 0 0;
%     -C1 C1 0 0 0 0 0 0;
%     0 0 0 0 0 0 0 0;
%     0 0 0 0 0 0 0 0;
%     0 0 0 0 0 0 0 0;
%     0 0 0 0 0 0 0 0;
%     0 0 0 0 0 0 -L1 0;
%     0 0 0 0 0 0 0 0];
% F = [0 0 0 0 0 vin 0 vout]';






