function work
	set -l lines (/home/rabbit/brain/core/git-work/work $argv)
	set -l work_status $status
	for line in $lines
		if string match -q -- '-> *' $line
			cd (string sub --start 4 -- $line)
		else
			echo $line
		end
	end
	return $work_status
end
