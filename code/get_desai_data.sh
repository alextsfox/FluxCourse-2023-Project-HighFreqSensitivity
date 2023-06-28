# set the download location, start, and end timeframe
datadir=/Users/alex/Documents/Data/FluxCourse/Project/raw-data/Ankur-Desai/fast
start="2019-02-04"
end="2019-12-31"

# download the data, could take up to 30 minutes for a year of data
python _get_desai_data.py --dest $datadir --start $start --end $end

# find .tar.gz files in the data directory
files=$(ls ${datadir}/*.tar.gz)

for FILE in $files
do
    # unzip
    tar -xf $FILE -C $datadir
    # copy half hourly files to the main data directory
    cp $datadir/air/incoming/lcreek/current/LostCreek_ts_data_*.dat $datadir
    # delete the zip file
    rm $FILE
done

# delete the unzipped directory
rm -r $datadir/air

echo "Done"