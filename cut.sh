#/bin/sh

IFS_old=$IFS
IFS=$'\n'

files=`ls /var/root/Movies/龙珠超\ Dragon\ Ball\ Super\ EP01-EP131\ 1080P\ WEB-DL/*.mp4`

for file in $files; do
    # echo $file;
    # echo ${file%.mp4}
    number=$(expr $file : 'EP\d+')
    echo $number
    # ffmpeg -ss 180 -t 1130 -accurate_seek -i "$file" -codec copy -avoid_negative_ts 1 "${file%.mp4}.cut.mp4"
done;

IFS=$IFS_old
