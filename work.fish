function work
	begin
		set -l IFS
		set output (/path/to/work $argv);
	end
	echo $output
	switch $output
		case "*-> *"
	   cd (echo $output | sed "s/-> //g")
	end
end
