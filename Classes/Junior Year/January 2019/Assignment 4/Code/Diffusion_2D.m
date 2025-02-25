%%
% This script takes in parameters defining the configuration of the 2D diffusion problem
% and simulates its diffusion with various plots to help understand the situation
% through time as the temperature changes through time

close all
clear all


%% Specifying parameters

% Number of cells in each direction
nx=50;               % Number of steps in space(x)
ny=50;               % Number of steps in space(y) 

% Length of grid
L = 1.5;
H = 1.2;

% Time parameters for simulation
nt=100;              % Number of time steps 
dt=0.001;             % Width of each time step

% Defining the length of each cell sized linearly
dx=L/(nx-1);       % Width of space step(x)
dy=H/(ny-1);       % Width of space step(y)
x=0:dx:L;          % Range of x(0,1.5) and specifying the grid points
y=0:dy:H;          % Range of y(0,1.2) and specifying the grid points

% Assigning temperatures to the cells with T and Tn
T = zeros(nx,ny);       % Preallocating T
k = zeros(nx,ny);
% Assigning the diffustion coefficient/ viscocity numbers to use for the right sections of the grid of cells
vis_x_11_14 = 0.06;   % Diffusion coefficient k / viscocity
vis_y_05_07 = 0.06;   % Diffusion coefficient k / viscocity
vis_rem     = 22;     % Diffusion coefficient k / viscocity


%% Creating initial matricies for T and k in order to iterate over these to change T with each iteration to find steady state solution


for i=1:nx
    for j=1:ny
        if (L/nx)*i > 1.1 && (L/nx)*i < 1.4         % Assigns the k values to their respective cell
            k(i,j) = vis_x_11_14;
        elseif (H/ny)*j > 0.5 && (H/ny)*j < 0.7   
            k(i,j) = vis_y_05_07;
        else                                      
            k(i,j) = vis_rem;
        end
    end
end

for i=1:nx
    for j=1:ny
        if j == 1                                  % Assigns the south boundary cells (y=0) to 16 degrees C
            T(i,j)=16;
        elseif i == nx                             % Assigns the west boundary cells  (x=0) to 11 degrees C
            T(i,j)= 11;
        elseif j == ny                             % Assigns the north boundary cells (y=1.2) to a varying degrees C
            T(i,j)=(20*(1+cos(pi*x(i)/L)));
        elseif i == 1                              % Assigns the east boundary cells  (x=1.5) to a varying degrees C
            T(i,j)=(12+20*(sin(pi*y(j)/H)));
        else                                       % Assigns the inside cells to 0 degrees C
            T(i,j)=0;  
        end
    end
end

%% Loop to iterate and calculate the T matrix 5000 times towards final convergence
T2 = T;

for int = 1:5000
    for i = 2:(nx-1)
        for j = 2:(ny-1)
            T2(i,j) = (k(i+1,j)*T(i+1,j) + k(i-1,j)*T(i-1,j) + k(i,j+1)*T(i,j+1) + k(i,j-1)*T(i,j-1)) / (k(i+1,j) + k(i-1,j) + k(i,j+1) + k(i,j-1)); % Calculate the new T matrix
        end
    end
    
    
    % These if statements with for loops helps calculate flux between iteration 199 and 200 by calculating difference of T and then apply k to it 
    if int == 199
        for i = 2:(nx-1)
            for j = 2:(ny-1)
                TotalFlux_x(i,j) = (k(i+1,j)*T(i+1,j) + k(i-1,j)*T(i-1,j)) / (k(i+1,j) + k(i-1,j));
                TotalFlux_y(i,j) = (k(i,j+1)*T(i,j+1) + k(i,j-1)*T(i,j-1)) / (k(i,j+1) + k(i,j-1));
                TotalFlux(i,j) = (k(i+1,j)*T(i+1,j) + k(i-1,j)*T(i-1,j) + k(i,j+1)*T(i,j+1) + k(i,j-1)*T(i,j-1)) / (k(i+1,j) + k(i-1,j) + k(i,j+1) + k(i,j-1));
            end
        end
    end
    if int == 200
        for i = 2:(nx-1)
            for j = 2:(ny-1)
                TotalFlux_x(i,j) = k(i,j)*(TotalFlux_x(i,j)-((k(i+1,j)*T(i+1,j) + k(i-1,j)*T(i-1,j)) / (k(i+1,j) + k(i-1,j))));
                TotalFlux_y(i,j) = k(i,j)*(TotalFlux_y(i,j)-((k(i,j+1)*T(i,j+1) + k(i,j-1)*T(i,j-1)) / (k(i,j+1) + k(i,j-1))));
                TotalFlux(i,j) = k(i,j)*(TotalFlux(i,j)-((k(i+1,j)*T(i+1,j) + k(i-1,j)*T(i-1,j) + k(i,j+1)*T(i,j+1) + k(i,j-1)*T(i,j-1)) / (k(i+1,j) + k(i-1,j) + k(i,j+1) + k(i,j-1))));
            end
        end
    end
    T = T2;
end

%% Plotting Data T


% Mesh Convergence Plots
figure(1)
imagesc(T)
xlabel('Number of Cells (x-direction) [ ]')
ylabel('Number of Cells (y-direction) [ ]')
colorbar

figure(2)
imagesc(Diffusion_2D_MoreCells(100,100))
xlabel('Number of Cells (x-direction) [ ]')
ylabel('Number of Cells (y-direction) [ ]')
colorbar

figure(3)
imagesc(Diffusion_2D_MoreCells(500,500))
xlabel('Number of Cells (x-direction) [ ]')
ylabel('Number of Cells (y-direction) [ ]')
colorbar

% Contour Plot of Temperature
figure(4)
contour(T,'ShowText','on')
xlabel('Number of Cells (x-direction) [ ]')
ylabel('Number of Cells (y-direction) [ ]')


% 3D Color Plot of Temperature
figure(5)
contour3(T)
xlabel('Number of Cells (x-direction) [ ]')
ylabel('Number of Cells (y-direction) [ ]')
zlabel('Temperature [�C]')


% Vector Plot of the Heat Flux
figure(6)
[x,y] = meshgrid(x(1:49),y(1:49));
quiver(x,y,TotalFlux_x,TotalFlux_y);
xlabel('Distance [m]')
ylabel('Distance [m]')

% Heat Flux 3D Color Plot
figure(7)
surf(x,y,TotalFlux)
xlabel('Distance [m]')
ylabel('Distance [m]')
zlabel('Total Flux [W/m^2]')
% 2 Additional Plots
figure(8)
imagesc(TotalFlux)
xlabel('Number of Cells (x-direction) [ ]')
ylabel('Number of Cells (y-direction) [ ]')
colorbar


figure(9)
contour3(Diffusion_2D_NoNorthHT(100,100))
xlabel('Number of Cells (x-direction) [ ]')
ylabel('Number of Cells (y-direction) [ ]')
zlabel('Temperature [�C]')

figure(13)
imagesc(Diffusion_2D_NoNorthHT(100,100))
xlabel('Number of Cells (x-direction) [ ]')
ylabel('Number of Cells (y-direction) [ ]')
colorbar


% For Modified BC, 3D Contour Plot of Temperature
figure(10)
imagesc(Diffusion_2D_Iterations(50))
xlabel('Number of Cells (x-direction) [ ]')
ylabel('Number of Cells (y-direction) [ ]')
colorbar

figure(11)
imagesc(Diffusion_2D_Iterations(500))
xlabel('Number of Cells (x-direction) [ ]')
ylabel('Number of Cells (y-direction) [ ]')
colorbar

figure(12)
imagesc(Diffusion_2D_Iterations(5000))
xlabel('Number of Cells (x-direction) [ ]')
ylabel('Number of Cells (y-direction) [ ]')
colorbar




