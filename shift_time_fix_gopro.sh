# script is referenced from https://superuser.com/questions/492342/how-can-i-batch-shift-the-creation-date-of-files-on-os-x-10-6-8?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa

#usge:  bash ./shift_time_fix_gopro.sh dir reference_file correct_time_for_the_reference_time
#examle:  bash ./shift_time_fix_gopro.sh snowboarding_dir GOPR9642.JPG 0406125718
# time format - 0327160015 #date's format: 27th March 2015, 16:00

cd "$1"

ref_file=$2
new_time_for_that_file=$3



ref_file_timestamp=`stat -f %B -t %s "$ref_file"`
new_time_timestamp=`date -j $new_time_for_that_file +%s`
echo "ref_file_timestamp: $ref_file_timestamp"
echo "new_time_timestamp: $new_time_timestamp"
time_diff=$[$new_time_timestamp - $ref_file_timestamp]

echo "time_diff: $time_diff"

for f in *; do
    old=$(stat -f %B -t %s "$f")
    new=$(date -r $(($old + $time_diff)) '+%m/%d/%Y %H:%M:%S')
    SetFile -d "$new" -m "$new" "$f"
done
