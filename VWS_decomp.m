%% Wind shear monthly 
SID={'CAMS-CSM1-0','FGOALS-g3','TaiESM1','CNRM-CM6-1','IPSL-CM6A-LR','MRI-ESM2-0','CESM2','CMCC-CM2-SR5','CESM2-WACCM','NorESM2-MM','NorESM2-LM','ACCESS-ESM1-5','ACCESS-CM2','AWI-CM-1-1-MR','BCC-CSM2-MR','CanESM5','EC-Earth3','EC-Earth3-Veg','INM-CM4-8','INM-CM5-0','GFDL-ESM4','MPI-ESM1-2-HR','MPI-ESM1-2-LR','MIROC6','NESM3','FIO-ESM-2-0'}
var={'ua','va','ta','psl','hus'}
x=1
Proj = {'SSP245','SSP685','historical'} % ,'GFDL-ESM4','CIESM','NorESM2-MM'


Absvortmap850h=[]
Absvortmap200h=[]
for q = 1:length(SID)
        FileName   = 'Wind_Shear_monthlydecomp.mat';
        D = ['/Volumes/Elements/PhD/data/SAVING/' SID{q}];
        File       = fullfile(D, FileName);
        load(File); 
        ws_s=ws_s.';
        ws_h=ws_h.';
        Absvortmap850h(:,:,q) = (u850hist.') ;    
        Absvortmap200h(:,:,q) = (u200hist.') ;    
end 
