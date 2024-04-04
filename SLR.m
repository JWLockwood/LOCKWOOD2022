% Change the working directory to the specified path for Matlab SLR analysis
cd('/Users/ ');

% Define a cell array of Simulation IDs for Climate Models
SID = {'ACCESS-ESM1-5', 'ACCESS-CM2', 'AWI-CM-1-1-MR', 'BCC-CSM2-MR', 'CanESM5', 'CMCC-CM2-SR5', 'CESM2-WACCM', 'CNRM-CM6-1', 'CESM2', 'CAMS-CSM1-0', 'EC-Earth3', 'EC-Earth3-Veg', 'FGOALS-g3', 'FIO-ESM-2-0', 'GFDL-ESM4', 'IPSL-CM6A-LR', 'INM-CM4-8', 'INM-CM5-0', 'MPI-ESM1-2-LR', 'MRI-ESM2-0', 'MPI-ESM1-2-HR', 'MIROC6', 'NorESM2-MM', 'NorESM2-LM', 'NESM3', 'TaiESM1'};

% Specify the filename of the netCDF data to be used in the analysis
f = 'separate-component-slr-rcp85.nc';

% Helper function to load data from a given file
function data = loadData(modelID, fileName)
    baseDir = '/Volumes/Elements/PhD/data/SAVING/'; % Base directory for model data
    fullPath = fullfile(baseDir, modelID, fileName); % Full path to the data file
    data = load(fullPath); % Load and return the data
end

% Loop through each Simulation ID to process model-specific data
for q = 1:length(SID)
    modelID = SID{q}; % Current model ID
    
    % Load data for each component of SLR from their respective files
    Steric2 = loadData(modelID, 'Steric2.mat');
    GIA = loadData(modelID, 'GIA.mat');
    larmipAIS = loadData(modelID, 'larmipAIS.mat');
    SMB_ANT_total = loadData(modelID, 'SMB_ANT_total.mat');
    furst2015GIS = loadData(modelID, 'furst2015GIS.mat');
    Glaciers2 = loadData(modelID, 'Glaciers2.mat');
    
    % Combine components to calculate total SLR for the current model
    % Assuming each file loaded contains variables directly used here.
    % You might need to adjust variable names based on actual contents.
    Total_SLR = Steric2.r_glt + larmipAIS.AISdynamics + SMB_ANT_total.totalANTsmb + furst2015GIS.GIStotalm + Glaciers2.ssp685_tempmaps + Glaciers2.Nonn;
    
    % Further processing of Total_SLR as needed
end

% Note: This code assumes that each .mat file contains variables directly usable in the Total_SLR calculation.
% You may need to adjust the structure accesses (e.g., Steric2.r_glt) based on the actual file contents.
