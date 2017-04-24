%%%%%%%%%%%%%%%%%%%%%
%% Clean Console
%%%%%%%%%%%%%%%%%%%%%
clear 
clc
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Setup           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('--------------------SETUP-------------------\n')
%%%%%%%
%% Load All Paths and Functions 
%%      - loads and updates files in program directory used in program     
%%%%%%%
global dir_main
dir_main = pwd;
addpath(genpath(dir_main))

%%%%%%%%%%%%%%%%%%%%%
%% Import Dynamic Inputs
%%%%%%%%%%%%%%%%%%%%%
run('inputs/include.m'); 

%%%%%%%%%%%%%%%%%%%%%
%% Setup Simulation Domains
%%%%%%%%%%%%%%%%%%%%%
run('setup/initialize_domain.m');
run('setup/initialize_conductor.m'); 
run('setup/clean_workspace.m'); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n--------------------Calculate-------------------\n')
run('calculate/include.m'); 
