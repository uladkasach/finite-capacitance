%%%%%%%%%%%%%%%%%%%
%% Calculate length/element in each direction
%%%%%%%%%%%%%%%%%%%
Dx = Lx/Nx;
Dy = Ly/Ny;
Dz = Lz/Nz;
length_per_element = [Dx, Dy, Dz];



%%%%%%%%%%%%%%%%%%%%
%% Generate a tensor of size Nx, Ny, Nz
%%%%%%%%%%%%%%%%%%%%
% global_base_domain_tensor = zeros(Nx, Ny, Nz);    
% Creating global tensor is avoided because of ram requirements

