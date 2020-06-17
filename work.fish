function work
	begin
		set -l IFS
		set output (path/to/work/script $argv);
	end
	switch $output
		case "*-> *"
	   cd (echo $output | rg "\->" | sed "s/-> //g")
	end
	echo $output | rg -v "\->"
end
