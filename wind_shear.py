
import xarray as xr, numpy as np, pandas as pd

def wind_shear(u850, v850, u200, v200):
    '''calculate wind shear between 850hPa and 200hPa'''
    Vshear = ( (u200 - u850)**2 + (v200 - v850)**2 )**0.5
    Vshear.attrs['long_name'] = '850-200hPa wind shear'
    Vshear.attrs['units'] = 'm/s'

    return Vshear

if __name__ == '__main__':
    ifile = '.nc'
    ds = xr.open_dataset(ifile).sel(pfull=slice(100, None))
    is_ocean = ds.land_mask.load() < 0.1
    u850 = ds.ucomp.interp(pfull=850)
    v850 = ds.vcomp.interp(pfull=850)
    u200 = ds.ucomp.interp(pfull=200)
    v200 = ds.vcomp.interp(pfull=200)
    Vshear = wind_shear(u850=u850, v850=v850, 
        u200=u200, v200=v200)
