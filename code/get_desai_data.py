from urllib import request
from pandas import date_range
from time import sleep
from tqdm import tqdm

def main():
    # input start and end dates to grab from remote server
    start = '2019-01-01'
    end = '2019-12-31'

    # don't change this stuff
    dates = date_range(start, end, freq='1D')
    years = dates.year.astype(int)
    months = dates.month.astype(int)
    days = dates.day.astype(int)

    remote_files = [
        f'http://co2.aos.wisc.edu/data/lcreek-raw/output/{year:04d}/US-Los_{year:04d}{month:02d}{day:02d}_L0rawdata.tar.gz' 
        for year, month, day in zip(years, months, days)
    ]

    local_files = [
        f"/Users/alex/Documents/Data/FluxCourse Project/raw-data/Ankur-Desai/fast/{year:04d}{month:02d}{day:02d}.tar.gz"
        for year, month, day in zip(years, months, days)
    ]

    for remote, local in zip(tqdm(remote_files), local_files):
        request.urlretrieve(remote, local)
        sleep(1)


if __name__ == '__main__':
    main()

