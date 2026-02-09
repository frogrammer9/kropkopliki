function dot
	function dot_update
	end

	function dot_help
		echo "Usage: dot <command>"
		echo "Commands:"
		echo "  update			Update dotfiles"
		echo "  move <path>		Move dotfiles to <path> (keeps the env up to date)"
		echo "  configure		Configure dotfiles"
		echo "  help			Show this message"
	end

	if test (count $argv) -eq 0
		dot_help
		return
	end

	switch $argv[1]
		case configure
			if test (count $argv) -ne 1
				dot_help
				return
			end
			"$DOTFILES/bin/configure.sh"
		case update
			if test (count $argv) -ne 1
				dot_help
				return
			end
			"$DOTFILES/bin/update.sh"
		case move 
			if test (count $argv) -ne 2
				dot_help
				return
			end
			"$DOTFILES/bin/move" "$argv[2]"
		case help
			if test (count $argv) -ne 1
				dot_help
				return
			end
			dot_help
		case '*'
			echo "Unknown command: '$argv[1]'"
			dot_help
	end
end
