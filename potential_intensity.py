
#import xarray as xr, numpy as np, pandas as pd
#import matplotlib.pyplot as plt
import numpy as np, xarray as xr

from pcmin import pcmin3

def potential_intensity(sst, slp, p, T, q, dim_x, dim_y, dim_z):
    '''xarray-wrapper of the FORTRAN module pcmin3_kflag.
    sst: sea surface temperature;
    slp: seal level pressure;
    p: pressure levels;
    T: temperature;
    q: specific humidity;
    xname: dim name along the x/lon direction;
    yname: dim name along the y/lat direction;
    zname: dim name along the z/p direction.
    '''
    r_v = q/(1-q) # specific humidity to mixing ratio
    pmin, vmax, iflag = xr.apply_ufunc(pcmin3,
        sst, slp, p, T, r_v,
        input_core_dims=[[dim_y, dim_x], [dim_y, dim_x], [dim_z], [dim_z, dim_y, dim_x], [dim_z, dim_y, dim_x]],
        output_core_dims=[[dim_y, dim_x], [dim_y, dim_x], []],
        vectorize=True)
    pmin.attrs['long_name'] = 'mininum central pressure'
    pmin.attrs['units'] = 'hPa'
    vmax.attrs['long_name'] = 'maximum surface wind speed'
    vmax.attrs['units'] = 'm/s'
    
    return PI

if __name__ == '__main__':
    ifile = ''
    ds = xr.open_dataset(ifile).sel(pfull=slice(100, None))
    PI = potential_intensity(sst, slp, p, T, q, dim_x='grid_xt', dim_y='grid_yt', dim_z='pfull')
    PI.to_netcdf('PI_test.nc', encoding={dname:{'zlib': True, 'complevel': 1} for dname in ('pmin', 'vmax')})
