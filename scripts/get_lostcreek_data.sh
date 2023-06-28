#!/bin/bash

###############
# ¡Change me! #
###############
# set the download location for the high frequency and biomet data
fastdatadir=/Users/alex/Documents/Data/FluxCourse/Project/raw-data/Lost-Creek/fast
biomdatadir=/Users/alex/Documents/Data/FluxCourse/Project/raw-data/Lost-Creek/biomet
# set the date range to download files for
start="2020-06-21"
end="2020-09-21"

#####################
# ¡Don't Change me! #
#####################
# download the data, could take up to 30 minutes for a year of data
echo "Downloading High Frequency Files"
python _get_lostcreek_hf_data.py --dest $fastdatadir --start $start --end $end

# find .tar.gz files in the data directory
files=$(ls ${fastdatadir}/*.tar.gz)

echo "Extracting Files"
for FILE in $files
do
    echo "Unzipping $FILE"
    # unzip
    tar -xf $FILE -C $fastdatadir
    # copy half hourly files to the main data directory
    cp $fastdatadir/air/incoming/lcreek/current/LostCreek_ts_data_*.dat $fastdatadir
    # delete the zip file
    rm $FILE 
done
# delete the last unzipped directory
rm -r $fastdatadir/air

echo "Downloading Biomet Files"
python _get_lostcreek_biomet_data.py --dest $biomdatadir --start $start --end $end

echo "Done"