
clear all; close all;
Working_Fluid_1 = {'R290'};
Working_Fluid_1 = Working_Fluid_1{1};
Max_Pressure  = 4250000;

%%%%%%%%%%%%%
% Constants for the Refridgeration Cycle for Durham, NH
%%%%%%%%%%%%%

Cold_Space = 273+20;            % Kelvin - Temperature of Cold Space of Pod
Hot_Space_Liftoff  = 273 + 50;  % Hottest Outside Environment
Cold_Space_Apogee   = 273 - 20; % Coldest Outside Environment

%%% Summer is used to refer to Liftoff, and Winter is for Apogee %%%

%%%%%%%%%%%%%
% Location 1 - Between Evaporator and Compressor
%%%%%%%%%%%%%

% Finding all values of the fluid at location 1
Q_1 = 1; % Saturated Vapor
T_1 = Cold_Space-5; % Temperature from 4 to 1
P_1 = CoolProp.PropsSI('P', 'T', T_1, 'Q', Q_1, Working_Fluid_1);
H_1 = CoolProp.PropsSI('H', 'T', T_1, 'Q', Q_1, Working_Fluid_1);
U_1 = CoolProp.PropsSI('U', 'T', T_1, 'Q', Q_1, Working_Fluid_1);
S_1 = CoolProp.PropsSI('S', 'T', T_1, 'Q', Q_1, Working_Fluid_1);
V_1 = 1/CoolProp.PropsSI('D', 'T', T_1, 'Q', Q_1, Working_Fluid_1);

Q_1_Apogee = 1; % Saturated Vapor
T_1_Apogee = Cold_Space_Apogee+5; % Temperature from 4 to 1
P_1_Apogee = CoolProp.PropsSI('P', 'T', T_1_Apogee, 'Q', Q_1, Working_Fluid_1);
H_1_Apogee = CoolProp.PropsSI('H', 'T', T_1_Apogee, 'Q', Q_1, Working_Fluid_1);
U_1_Apogee = CoolProp.PropsSI('U', 'T', T_1_Apogee, 'Q', Q_1, Working_Fluid_1);
S_1_Apogee = CoolProp.PropsSI('S', 'T', T_1_Apogee, 'Q', Q_1, Working_Fluid_1);
V_1_Apogee = 1/CoolProp.PropsSI('D', 'T', T_1_Apogee, 'Q', Q_1, Working_Fluid_1);

%%%%%%%%%%%%%
% Location 3 - Between Condensor and Expansion Valve - Saturated Liquid
%%%%%%%%%%%%%

% Finding all values of the fluid at location 3
Q_3 = 0; % Saturated Liquid
T_3_Summer = Hot_Space_Liftoff + 5; % Temperature from 4 to 1
P_3_Summer = CoolProp.PropsSI('P', 'T', T_3_Summer, 'Q', Q_3, Working_Fluid_1);
H_3_Summer = CoolProp.PropsSI('H', 'T', T_3_Summer, 'Q', Q_3, Working_Fluid_1);
U_3_Summer = CoolProp.PropsSI('U', 'T', T_3_Summer, 'Q', Q_3, Working_Fluid_1);
S_3_Summer = CoolProp.PropsSI('S', 'T', T_3_Summer, 'Q', Q_3, Working_Fluid_1);
V_3_Summer = 1/CoolProp.PropsSI('D', 'T', T_3_Summer, 'Q', Q_3, Working_Fluid_1);

T_3_Winter = Cold_Space-5; % Temperature from 4 to 1
P_3_Winter = CoolProp.PropsSI('P', 'T', T_3_Winter, 'Q', Q_3, Working_Fluid_1);
H_3_Winter = CoolProp.PropsSI('H', 'T', T_3_Winter, 'Q', Q_3, Working_Fluid_1);
U_3_Winter = CoolProp.PropsSI('U', 'T', T_3_Winter, 'Q', Q_3, Working_Fluid_1);
S_3_Winter = CoolProp.PropsSI('S', 'T', T_3_Winter, 'Q', Q_3, Working_Fluid_1);
V_3_Winter = 1/CoolProp.PropsSI('D', 'T', T_3_Winter, 'Q', Q_3, Working_Fluid_1);

%%%%%%%%%%%%%
% Location 2 - Between Condensor and Expansion Valve Super-Heated Vapor
%%%%%%%%%%%%%

% Finding all values of the fluid at location 2
S_2_Summer = S_1; % Constant Entropy
P_2_Summer = P_3_Summer; % Constant Pressure Isobar
T_2_Summer = CoolProp.PropsSI('T', 'P', P_2_Summer, 'S', S_2_Summer, Working_Fluid_1);
H_2_Summer = CoolProp.PropsSI('H', 'P', P_2_Summer, 'S', S_2_Summer, Working_Fluid_1);
U_2_Summer = CoolProp.PropsSI('U', 'P', P_2_Summer, 'S', S_2_Summer, Working_Fluid_1);
V_2_Summer = 1/CoolProp.PropsSI('D', 'P', P_2_Summer, 'S', S_2_Summer, Working_Fluid_1);

P_2_Winter = P_3_Winter; % Constant Pressure Isobar
S_2_Winter = S_1_Apogee; % Constant Entropy
T_2_Winter = CoolProp.PropsSI('T', 'P', P_2_Winter, 'S', S_2_Winter, Working_Fluid_1);
H_2_Winter = CoolProp.PropsSI('H', 'P', P_2_Winter, 'S', S_2_Winter, Working_Fluid_1);
U_2_Winter = CoolProp.PropsSI('U', 'P', P_2_Winter, 'S', S_2_Winter, Working_Fluid_1);
V_2_Winter = 1/CoolProp.PropsSI('D', 'P', P_2_Winter, 'S', S_2_Winter, Working_Fluid_1);

%%%%%%%%%%%%%
% Location 2a - On Vapor Dome During the process 2 to 3 in condensor
%%%%%%%%%%%%%

% Finding all values of the fluid at location 2a
Q_2a=1; % On Vapor Dome as Saturdated Vapor
P_2a_Summer = P_2_Summer; % Isobar = Constant Pressure
T_2a_Summer = T_3_Summer; % Constant Temperature from T3
S_2a_Summer = CoolProp.PropsSI('S', 'P', P_2a_Summer, 'Q', Q_2a, Working_Fluid_1);
H_2a_Summer = CoolProp.PropsSI('H', 'P', P_2a_Summer, 'Q', Q_2a, Working_Fluid_1);
U_2a_Summer = CoolProp.PropsSI('U', 'P', P_2a_Summer, 'Q', Q_2a, Working_Fluid_1);
V_2a_Summer = 1/CoolProp.PropsSI('D', 'P', P_2a_Summer, 'Q', Q_2a, Working_Fluid_1);

P_2a_Winter = P_2_Winter; % Isobar = Constant Pressure
T_2a_Winter = T_3_Winter; % Constant Temperature from T3
S_2a_Winter = CoolProp.PropsSI('S', 'P', P_2a_Winter, 'Q', Q_2a, Working_Fluid_1);
H_2a_Winter = CoolProp.PropsSI('H', 'P', P_2a_Winter, 'Q', Q_2a, Working_Fluid_1);
U_2a_Winter = CoolProp.PropsSI('U', 'P', P_2a_Winter, 'Q', Q_2a, Working_Fluid_1);
V_2a_Winter = 1/CoolProp.PropsSI('D', 'P', P_2a_Winter, 'Q', Q_2a, Working_Fluid_1);

%%%%%%%%%%%%%
% Location 4 - Mixture between the expansion valve and evaporator
%%%%%%%%%%%%%

% Finding all values of the fluid at location 4
T_4 = T_1; % Constant Temperature from 4 to 1 Process
H_4_Summer = H_3_Summer; % Expansion Valve is ~ constant enthalpy process
P_4_Summer = P_1; % Isobaric Process
U_4_Summer = CoolProp.PropsSI('U', 'P', P_4_Summer, 'H', H_4_Summer, Working_Fluid_1);
S_4_Summer = CoolProp.PropsSI('S', 'P', P_4_Summer, 'H', H_4_Summer, Working_Fluid_1);
V_4_Summer = 1/CoolProp.PropsSI('D', 'P', P_4_Summer, 'H', H_4_Summer, Working_Fluid_1);

T_4_Winter = T_1_Apogee; % Constant Temperature from 4 to 1 Process
H_4_Winter = H_3_Winter; % Expansion Valve is ~ constant enthalpy process
P_4_Winter = P_1_Apogee; % Isobaric Process
U_4_Winter = CoolProp.PropsSI('U', 'P', P_4_Winter, 'H', H_4_Winter, Working_Fluid_1);
S_4_Winter = CoolProp.PropsSI('S', 'P', P_4_Winter, 'H', H_4_Winter, Working_Fluid_1);
V_4_Winter = 1/CoolProp.PropsSI('D', 'P', P_4_Winter, 'H', H_4_Winter, Working_Fluid_1);

%%%%%%%%%%%%%
% Calculations of the Vapor Dome for the Refridgeration Cycle
% Will be plotted as a T-s and P-h Diagram
% Two curves will be plotted for each graph, one for the Saturated Liquid and one for Saturdated Vapor Sections
%%%%%%%%%%%%%

% Constant Variables and Pressure Array to Calculate Graph Values
Q_SL = 0; % Saturated Liquid
Q_SV = 1; % Saturated Vapor
P_SL_SV = linspace(100000,Max_Pressure,1000);  % Pressures for the Saturated Liquid Curve

T_SL = zeros(length(P_SL_SV));
S_SL = zeros(length(P_SL_SV));
H_SL = zeros(length(P_SL_SV));
V_SL = zeros(length(P_SL_SV));
T_SV = zeros(length(P_SL_SV));
S_SV = zeros(length(P_SL_SV));
H_SV = zeros(length(P_SL_SV));
V_SV = zeros(length(P_SL_SV));

% Looping 1000 times to provide values for the Vapor Dome Curves for T, s, h and v. P array will be graphed with them
for index=1:1000
    T_SL(index) = CoolProp.PropsSI('T', 'P', P_SL_SV(index), 'Q', Q_SL, Working_Fluid_1) -273;
    S_SL(index) = CoolProp.PropsSI('S', 'P', P_SL_SV(index), 'Q', Q_SL, Working_Fluid_1);
    H_SL(index) = CoolProp.PropsSI('H', 'P', P_SL_SV(index), 'Q', Q_SL, Working_Fluid_1);
    V_SL(index) = 1/CoolProp.PropsSI('D','P',P_SL_SV(index), 'Q', Q_SL, Working_Fluid_1);
    T_SV(index) = CoolProp.PropsSI('T', 'P', P_SL_SV(index), 'Q', Q_SV, Working_Fluid_1) -273;
    S_SV(index) = CoolProp.PropsSI('S', 'P', P_SL_SV(index), 'Q', Q_SV, Working_Fluid_1);
    H_SV(index) = CoolProp.PropsSI('H', 'P', P_SL_SV(index), 'Q', Q_SV, Working_Fluid_1);
    V_SV(index) = 1/CoolProp.PropsSI('D','P',P_SL_SV(index), 'Q', Q_SV, Working_Fluid_1);
end

%%%%%%%%%%%%%
% Calculations of Every Point during the Refridgeration Cycle
%%%%%%%%%%%%%

% Compressor Points - Points 1 to 2 - Constant Entropy

S_Compressor_Liftoff = S_1; % Constant Entropy Process
S_Compressor_Apogee = S_1_Apogee; % Constant Entropy Process
P_Compressor_Summer = linspace(P_1,P_2_Summer,1000);
P_Compressor_Winter = linspace(P_1_Apogee,P_2_Winter,1000);
T_Compressor_Summer = zeros(length(P_Compressor_Summer));
T_Compressor_Winter = zeros(length(P_Compressor_Summer));
S_Compressor_Summer = zeros(length(P_Compressor_Summer));
S_Compressor_Winter = zeros(length(P_Compressor_Summer));
H_Compressor_Summer = zeros(length(P_Compressor_Summer));
H_Compressor_Winter = zeros(length(P_Compressor_Summer));
V_Compressor_Summer = zeros(length(P_Compressor_Summer));
V_Compressor_Winter = zeros(length(P_Compressor_Summer));

for index = 1:1000
    T_Compressor_Summer(index) = CoolProp.PropsSI('T', 'P', P_Compressor_Summer(index), 'S', S_Compressor_Liftoff, Working_Fluid_1) - 273;
    T_Compressor_Winter(index) = CoolProp.PropsSI('T', 'P', P_Compressor_Winter(index), 'S', S_Compressor_Apogee, Working_Fluid_1) - 273;
    S_Compressor_Summer(index) = CoolProp.PropsSI('S', 'P', P_Compressor_Summer(index), 'S', S_Compressor_Liftoff, Working_Fluid_1);
    S_Compressor_Winter(index) = CoolProp.PropsSI('S', 'P', P_Compressor_Winter(index), 'S', S_Compressor_Apogee, Working_Fluid_1);
    H_Compressor_Summer(index) = CoolProp.PropsSI('H', 'P', P_Compressor_Summer(index), 'S', S_Compressor_Liftoff, Working_Fluid_1);
    H_Compressor_Winter(index) = CoolProp.PropsSI('H', 'P', P_Compressor_Winter(index), 'S', S_Compressor_Apogee, Working_Fluid_1);
    V_Compressor_Summer(index) = 1/CoolProp.PropsSI('D', 'P', P_Compressor_Summer(index), 'S', S_Compressor_Liftoff, Working_Fluid_1);
    V_Compressor_Winter(index) = 1/CoolProp.PropsSI('D', 'P', P_Compressor_Winter(index), 'S', S_Compressor_Apogee, Working_Fluid_1);
end

% Condensor - Points 2 to 2a - Constant Pressure

P_Condensor_Summer = P_2_Summer; % Constant Pressure Process
P_Condensor_Winter = P_2_Winter; % Constant Pressure Process
T_Condensor_Summer = linspace(T_2_Summer,T_2a_Summer+.25,1000); % Added constant .25 so it does not go to the mixture
T_Condensor_Winter = linspace(T_2_Winter,T_2a_Winter+.25,1000); % Added constant .25 so it does not go to the mixture
S_Condensor_Summer = zeros(length(P_Condensor_Summer));
S_Condensor_Winter = zeros(length(P_Condensor_Summer));
H_Condensor_Summer = zeros(length(P_Condensor_Summer));
H_Condensor_Winter = zeros(length(P_Condensor_Summer));
V_Condensor_Summer = zeros(length(P_Condensor_Summer));
V_Condensor_Winter = zeros(length(P_Condensor_Summer));
for index = 1:1000
    S_Condensor_Summer(index) = CoolProp.PropsSI('S', 'T', T_Condensor_Summer(index), 'P', P_Condensor_Summer, Working_Fluid_1);
    S_Condensor_Winter(index) = CoolProp.PropsSI('S', 'T', T_Condensor_Winter(index), 'P', P_Condensor_Winter, Working_Fluid_1);
    H_Condensor_Summer(index) = CoolProp.PropsSI('H', 'T', T_Condensor_Summer(index), 'P', P_Condensor_Summer, Working_Fluid_1);
    H_Condensor_Winter(index) = CoolProp.PropsSI('H', 'T', T_Condensor_Winter(index), 'P', P_Condensor_Winter, Working_Fluid_1);
    V_Condensor_Summer(index) = 1/CoolProp.PropsSI('D', 'T', T_Condensor_Summer(index), 'P', P_Condensor_Summer, Working_Fluid_1);
    V_Condensor_Winter(index) = 1/CoolProp.PropsSI('D', 'T', T_Condensor_Winter(index), 'P', P_Condensor_Winter, Working_Fluid_1);
end

% Condensor - Points 2a to 3 - Constant Pressure - Straight Line inside Vapor Dome

T_Condensora_Summer = [T_2a_Summer,T_3_Summer]; % Constant Temperature
T_Condensora_Winter = [T_2a_Winter,T_3_Winter]; % Constant Temperature
P_Condensora_Summer = [P_2a_Summer,P_3_Summer];
P_Condensora_Winter = [P_2a_Winter,P_3_Winter];
S_Condensora_Summer = [S_2a_Summer,S_3_Summer];
S_Condensora_Winter = [S_2a_Winter,S_3_Winter];
H_Condensora_Summer = [H_2a_Summer,H_3_Summer];
H_Condensora_Winter = [H_2a_Winter,H_3_Winter];
V_Condensora_Summer = [V_2a_Summer,V_3_Summer];
V_Condensora_Winter = [V_2a_Winter,V_3_Winter];

% Expansion Valve - Points 3 to 4 - Constant Enthalpy

H_Valve_Summer = H_3_Summer; % Constant Enthlpy Process
H_Valve_Winter = H_3_Winter; % Constant Enthlpy Process
P_Valve_Summer = linspace(P_3_Summer,P_4_Summer,1000); % Added constant .5 so it does not go to the mixture
P_Valve_Winter = linspace(P_3_Winter,P_4_Winter,1000); % Added constant .5 so it does not go to the mixture
S_Valve_Summer = zeros(length(P_Valve_Summer));
S_Valve_Winter = zeros(length(P_Valve_Summer));
T_Valve_Summer = zeros(length(P_Valve_Summer));
T_Valve_Winter = zeros(length(P_Valve_Summer));
V_Valve_Summer = zeros(length(P_Valve_Summer));
V_Valve_Winter = zeros(length(P_Valve_Summer));
for index = 1:1000
    S_Valve_Summer(index) = CoolProp.PropsSI('S', 'H', H_Valve_Summer, 'P', P_Valve_Summer(index), Working_Fluid_1);
    S_Valve_Winter(index) = CoolProp.PropsSI('S', 'H', H_Valve_Winter, 'P', P_Valve_Winter(index), Working_Fluid_1);
    T_Valve_Summer(index) = CoolProp.PropsSI('T', 'H', H_Valve_Summer, 'P', P_Valve_Summer(index), Working_Fluid_1);
    T_Valve_Winter(index) = CoolProp.PropsSI('T', 'H', H_Valve_Winter, 'P', P_Valve_Winter(index), Working_Fluid_1);
    V_Valve_Summer(index) = 1/CoolProp.PropsSI('D', 'H', H_Valve_Summer, 'P', P_Valve_Summer(index), Working_Fluid_1);
    V_Valve_Winter(index) = 1/CoolProp.PropsSI('D', 'H', H_Valve_Winter, 'P', P_Valve_Winter(index), Working_Fluid_1);
end

% Evaporator - Points 4 to 1 - Constant Temperature - Straight Line inside Vapor Dome

T_Evaporator_Summer = [T_4,T_1]; % Constant Temperature
T_Evaporator_Winter = [T_4_Winter,T_1_Apogee]; % Constant Temperature
P_Evaporator_Summer = [P_4_Summer,P_1];
P_Evaporator_Winter = [P_4_Winter,P_1_Apogee];
S_Evaporator_Summer = [S_4_Summer,S_1];
S_Evaporator_Winter = [S_4_Winter,S_1_Apogee];
H_Evaporator_Summer = [H_4_Summer,H_1];
H_Evaporator_Winter = [H_4_Winter,H_1_Apogee];
V_Evaporator_Summer = [V_4_Summer,V_1];
V_Evaporator_Winter = [V_4_Winter,V_1_Apogee];

%%%%%%%%%%%%%
% Calculation COP for each temperature
%%%%%%%%%%%%%

COP_Summer = (H_1 - H_4_Summer)/(H_2_Summer - H_1);
COP_Winter = (H_1_Apogee - H_4_Winter)/(H_2_Winter - H_1_Apogee);

%%%%%%%%%%%%%
% Graphing the T-s and P-h and P-vGraphs with Vapor Dome and Labels
%%%%%%%%%%%%%

% T-s Graph for the Summer
figure(1)
% Vapor Dome
plot(S_SL/1000,T_SL,'k',S_SV/1000,T_SV,'k')
hold on
% Processes

% Winter
plot(S_Compressor_Winter/1000,T_Compressor_Winter,'b',S_Condensor_Winter/1000, T_Condensor_Winter-273,'b',S_Condensora_Winter/1000, T_Condensora_Winter-273,'b',S_Valve_Winter/1000,T_Valve_Winter-273,'b',S_Evaporator_Winter/1000, T_Evaporator_Winter-273,'b')
text(S_1_Apogee/1000,T_1_Apogee-273, '\leftarrow State 1','FontSize', 8,'Color','blue')
text(S_2_Winter/1000,T_2_Winter-273, '\leftarrow State 2','FontSize', 8,'Color','blue')
text(S_3_Winter/1000-.2,T_3_Winter-273, 'State 3','FontSize', 8,'Color','blue')
text(S_4_Winter/1000-.02,T_4_Winter-273-3, 'State 4','FontSize', 8,'Color','blue')
text(1.6,20, strcat('Apogee COP: ' , num2str(COP_Winter)),'FontSize', 10,'Color','blue')
text(1.5,0, 'Heat Transfer Total = 5300 J/s','FontSize', 8,'Color','blue')

% Summer
plot(S_Compressor_Summer/1000,T_Compressor_Summer,'r',S_Condensor_Summer/1000, T_Condensor_Summer-273,'r',S_Condensora_Summer/1000, T_Condensora_Summer-273,'r',S_Valve_Summer/1000,T_Valve_Summer-273,'r',S_Evaporator_Summer/1000, T_Evaporator_Summer-273,'m')
%plot(S_Compressor_Winter/1000,T_Compressor_Winter,'b')
text(S_2a_Winter/1000,T_2a_Winter-273, '\leftarrow State 1','FontSize', 8,'Color','red')
text(S_2_Summer/1000,T_2_Summer-273, '\leftarrow State 2','FontSize', 8,'Color','red')
text(S_3_Summer/1000-.2,T_3_Summer-273, 'State 3','FontSize', 8,'Color','red')
text(S_4_Summer/1000-.1,T_4-273-2, 'State 4','FontSize', 8,'Color','red')
text(1.6,60, strcat('Takeoff COP: ' , num2str(COP_Summer)),'FontSize', 10,'Color','red')
text(1.5,40, 'Heat Transfer Total = 8000 J/s','FontSize', 8,'Color','red')

% Syntax
xlabel('Specific Entropy (kJ/kgK)','FontSize',20)
set(gca,'fontsize',17)
ylabel('Temperature (�C)','FontSize',20)
set(gca,'fontsize',20)
lgd = legend('\color{red} Takeoff','\color{blue} Apogee','\color{black} Vapor Dome','Location','NorthWest');
lgd.FontSize = 16;
xlim([.5 2.75])
ylim([-30 100])
hold off


% P-h Graph for the Summer
figure(2)
% Vapor Dome
plot(H_SL/1000,P_SL_SV/1000,'k',H_SV/1000,P_SL_SV/1000,'k')
hold on

% Processes

%Winter
P_Condensor_Winter = [P_2_Winter,P_2a_Winter];
H_Condensor_Winter = [H_2_Winter,H_2a_Winter];
P_Valve_Winter_Ph = [P_3_Winter,P_4_Winter];
H_Valve_Winter_Ph = [H_3_Winter,H_4_Winter];
plot(H_Compressor_Winter/1000,P_Compressor_Winter/1000,'b',H_Condensor_Winter/1000, P_Condensor_Winter/1000,'b',H_Condensora_Winter/1000, P_Condensora_Winter/1000,'b',H_Valve_Winter_Ph/1000,P_Valve_Winter_Ph/1000,'b',H_Evaporator_Winter/1000, P_Evaporator_Winter/1000,'b')
text(H_1_Apogee/1000,P_1_Apogee/1000, '\leftarrow State 1','FontSize', 8,'Color','blue')
text(H_2_Winter/1000,P_2_Winter/1000, '\leftarrow State 2','FontSize', 8,'Color','blue')
text(H_3_Winter/1000-55,P_3_Winter/1000, 'State 3','FontSize', 8,'Color','blue')
text(H_4_Winter/1000-55,P_4_Winter/1000+35, 'State 4','FontSize', 8,'Color','blue')
text(400,900, strcat('Apogee COP: ' , num2str(COP_Winter)),'FontSize', 10,'Color','blue')
text(300,500, 'Heat Transfer Total = 5300 J/s','FontSize', 8,'Color','blue')

% Summer
P_Condensor_Summer = [P_2_Summer,P_2a_Summer];
H_Condensor_Summer = [H_2_Summer,H_2a_Summer];
P_Valve_Summer_Ph = [P_3_Summer,P_4_Summer];
H_Valve_Summer_Ph = [H_3_Summer,H_4_Summer];
plot(H_Compressor_Summer/1000,P_Compressor_Summer/1000,'r',H_Condensor_Summer/1000, P_Condensor_Summer/1000,'r',H_Condensora_Summer/1000, P_Condensora_Summer/1000,'r',H_Valve_Summer_Ph/1000,P_Valve_Summer_Ph/1000,'r',H_Evaporator_Summer/1000, P_Evaporator_Summer/1000,'m')
text(H_2_Winter/1000-65,P_2_Winter/1000-60, 'State 1','FontSize', 8,'Color','red')
text(H_2_Summer/1000-3,P_2_Summer/1000, '\leftarrow State 2','FontSize', 8,'Color','red')
text(H_3_Summer/1000-55,P_3_Summer/1000, 'State 3','FontSize', 8,'Color','red')
text(H_4_Summer/1000-55,P_4_Summer/1000+90, 'State 4','FontSize', 8,'Color','red')
text(400,2050, strcat('Takeoff COP: ' , num2str(COP_Summer)),'FontSize', 10,'Color','red')
text(400,1500, 'Heat Transfer Total = 8000 J/s','FontSize', 8,'Color','red')

% Plot Syntax
xlabel('Enthalpy (kJ/K)','FontSize',22)
set(gca,'fontsize',20)
ylabel('Pressure (kPa)','FontSize',22)
set(gca,'fontsize',20)
lgd = legend('\color{red} Takeoff','\color{blue} Apogee','\color{black} Vapor Dome','Location','NorthWest');
lgd.FontSize = 16;
xlim([150 700])
ylim([100 3500])
hold off