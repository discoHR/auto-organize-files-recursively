#!/bin/bash

# phase 1 - move all files from all subdirectories into current directory
echo "Phase 1/5"
num_subfiles=`find . -mindepth 2 -type f -print | wc -l`
if [ $num_subfiles -gt 0 ]
then
	find . -mindepth 2 -type f -print0 | xargs -0 mv -f -t .
fi

# phase 2 - delete all subdirectories
echo "Phase 2/5"
ls */ >/dev/null 2>&1
if [ $? == 0 ]
then
	find . -mindepth 1 -type d -prune -print0 | xargs -0 rm -rf
fi

# phase 3 - lowercase all filenames
echo "Phase 3/5"
find . -type f -name "*[A-Z]*" -exec rename 's/(.*)\/([^\/]*)/$1\/\L$2/' "{}" \;
find . -type f -name "*[A-Z]*" -delete

# phase 4 - create new subdirectories and move files into them
echo "Phase 4/5"
mkdir "0-9" "a-e" "f-j" "k-o" "p-t" "u-z"
find . -maxdepth 1 -type f -iname "[0-9]*" -print0 | xargs -0 mv -f -t "0-9"
find . -maxdepth 1 -type f -iname "[a-e]*" -print0 | xargs -0 mv -f -t "a-e"
find . -maxdepth 1 -type f -iname "[f-j]*" -print0 | xargs -0 mv -f -t "f-j"
find . -maxdepth 1 -type f -iname "[k-o]*" -print0 | xargs -0 mv -f -t "k-o"
find . -maxdepth 1 -type f -iname "[p-t]*" -print0 | xargs -0 mv -f -t "p-t"
find . -maxdepth 1 -type f -iname "[u-z]*" -print0 | xargs -0 mv -f -t "u-z"

# phase 5 - do the magic in each subdirectory
echo "Phase 5/5"
for subdir in `ls -1 -d */`
do
	cd "$subdir"
	GROUP_SIZE=100
	TOTAL_FILES=`ls -lh | wc -l`
	GROUP_FILES=$(((TOTAL_FILES + GROUP_SIZE - 1) / GROUP_SIZE))
	while [ $GROUP_FILES -gt $GROUP_SIZE ]
	do
		GROUP_SIZE=$((GROUP_SIZE + 2))
		GROUP_FILES=$(((TOTAL_FILES + GROUP_SIZE - 1) / GROUP_SIZE))
	done
	current_group=0
	files_in_current_group=0
	group_dir="group$current_group"
	for file in *
	do
		if [ ! -d "$group_dir" ]
		then
			mkdir "$group_dir"
		fi
		mv -- "$file" "$group_dir"
		files_in_current_group=$((files_in_current_group + 1))
		if [ $files_in_current_group -gt $GROUP_SIZE ]
		then
			current_group=$((current_group + 1))
			files_in_current_group=0
			group_dir="group$current_group"
		fi
	done
	for dir in `ls -1 -d group*/`
	do
		first=`ls -1 $dir | head -n 1 | sed 's/[^a-zA-Z0-9]//g' | tr [A-Z] [a-z]`
		first=${first:0:3}
		last=`ls -1 $dir | tail -n 1 | sed 's/[^a-zA-Z0-9]//g' | tr [A-Z] [a-z]`
		last=${last:0:3}
		newdir="$first-$last"
		same_dir_count=1
		while [ -d "$newdir" ]
		do
			same_dir_count=$((same_dir_count + 1))
			newdir="$first-$last-$(printf "%02d" $same_dir_count)"
		done
		mv -- "$dir" "$newdir"
	done
	cd ..
done

echo "Done"
