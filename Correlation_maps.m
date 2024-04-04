% Load and Display NetCDF Data
filePath = '/Users/joelockwood/Desktop/WOA2001_grid.nc'; % File path for the netCDF data
ncdisp(filePath); % Display netCDF file contents

% Read Data from NetCDF File
bathy = ncread(filePath, 'bathy');
longitude = ncread(filePath, 'longitude');
latitude = ncread(filePath, 'latitude');

% Simulation IDs for Climate Models
SID = {'TaiESM1', 'NorESM2-MM', 'NorESM2-LM', 'CNRM-CM6-1', 'CESM2', 'ACCESS-ESM1-5', 'ACCESS-CM2', 'AWI-CM-1-1-MR', 'BCC-CSM2-MR', 'CanESM5', 'CMCC-CM2-SR5', 'CESM2-WACCM', 'EC-Earth3', 'EC-Earth3-Veg', 'FGOALS-g3', 'GFDL-ESM4', 'IPSL-CM6A-LR', 'INM-CM4-8', 'INM-CM5-0', 'MPI-ESM1-2-LR', 'MRI-ESM2-0', 'MPI-ESM1-2-HR', 'MIROC6', 'NESM3', 'CAMS-CSM1-0', 'FIO-ESM-2-0'};

% Latitude and Longitude Bounds for Analysis
latmins = [1, 110, 130, 75];
latmaxs = [180, 140, 130, 105];
lonmins = [1, 265, 120, 200];
lonmaxs = [360, 320, 200, 290];

% Process Data for Specified Latitude and Longitude Bounds
for p = 2:3
    % Extract bounds for current iteration for basin of interest.
    latmin = latmins(p);
    latmax = latmaxs(p);
    lonmin = lonmins(p);
    lonmax = lonmaxs(p);
    
    % Iterate over each climate model ID and load data for each mode
    for q = 1:length(SID)
        FileName   = 'Wind_Shear_monthly.mat'; D = ['/Volumes/Elements/PhD/data/SAVING/' SID{q}]; File       = fullfile(D, FileName); load(File); 
        VW(:,:,q) = (ws_s - ws_h) ;   
        FileName   = 'Sea_level_rise.mat'; D = ['/Volumes/Elements/PhD/data/SAVING/' SID{q}]; File       = fullfile(D, FileName); load(File); 
        SLR(:,:,q) = (SLR_for_models) ;   
    end
end

% Calculate and Visualize Correlations
% Initialize matrices to hold correlation coefficients and p-values
Pvalvi = NaN(360,180);
corvi = NaN(360,180);

% Iterate over each grid point
for u = 1:360
    for v = 1:180
        [R,P] = corr(squeeze(LSC(v,u,indx)),squeeze(SLRC(u,v,indx)),'Type','Spearman'); corvi(u,v) = R; Pvalvi(u,v) = P; end
    end
end

lat=-89.5:1:89.5;
lon=0.5:359.5;
ctype = 'div'
cname = 'RdBu'
ncol = 200
[colormap2]=cbrewer(ctype, cname, ncol)
m_proj('equidist','lat',[-60 60],'lon',[90 360],'sphere','sphere');

#### Plot datasets 

close all
hold on
vvv=1
for uu = 1:2;
    for vv = 1:5;
        ax2 = subplot(2,5,vvv)
        m_contourf(lon,lat,correlations(:,:,vvv).',9,'edgecolor','none')
    end
end

