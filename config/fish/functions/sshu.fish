function sshu
	set -l cmd $argv[1]
	set -l args $argv[2..-1]
	switch $cmd
		case gen
			argparse n/name= h/host= u/user= l/legacy help -- $args
			if not set -q _flag_name; or not set -q _flag_host; or set -q _flag_help
				echo "sshu gen:"
				echo "	-n/--name= - key name"
				echo "	-h/--host= - host that will use this key"
				echo "	-u/--user= [opt] - user name, if not set $USER will be used"
				echo "	-l/--legacy [opt] - will generate rsa key"
				echo "	--help [opt] - prints this message"
				if set -q _flag_help
					return 0
				end
				return 1
			end

			mkdir -p ~/.ssh/keys
			mkdir -p ~/.ssh/pubkeys
			mkdir -p ~/.ssh/config.d

			if not grep -q "Include ~/.ssh/config.d" ~/.ssh/config
				echo "Include ~/.ssh/config.d/*" >> ~/.ssh/config
			end

			if test -f ~/.ssh/keys/$_flag_name
				echo "Key with name '$_flag_name' already exists"
				return 2
			end

			if not set -q _flag_user
				set _flag_user $USER
			end

			if set -q _flag_legacy
				ssh-keygen -t rsa -b 4096 -C "" -f ~/.ssh/keys/$_flag_name
			else
				ssh-keygen -t ed25519 -C "" -f ~/.ssh/keys/$_flag_name
			end

			mv ~/.ssh/keys/$_flag_name.pub ~/.ssh/pubkeys/

			echo "Host $_flag_name" >> ~/.ssh/config.d/"$_flag_name".conf
			echo "	Hostname $_flag_host" >> ~/.ssh/config.d/"$_flag_name".conf
			echo "	User $_flag_user" >> ~/.ssh/config.d/"$_flag_name".conf
			echo "	IdentityFile ~/.ssh/keys/$_flag_name" >> ~/.ssh/config.d/"$_flag_name".conf

		case del
			set -l name $args[1]

			if test -z "$name"
				echo "Usage: sshu del name - deletes the key with name: 'name'"
				return 1
			end

			if not test -f ~/.ssh/keys/"$name"
				return 0
			end

			rm ~/.ssh/keys/"$name"
			rm ~/.ssh/pubkeys/"$name".pub
			rm ~/.ssh/config.d/"$name".conf
			
		case list
			set -l lcmd $args[1]
			if test -z $lcmd
				set lcmd "all"
			end

			switch $lcmd
				case all
					ls -1 ~/.ssh/keys
				case up
					ssh-add -L
				case '*'
					echo "sshu list cmd:"
					echo "	all [default] - lists all avaliable keys"
					echo "	up - lists currently active keys"
			end

		case up
			argparse n/name= a/all help -- $args

			if set -q _flag_help
				echo "sshu up:"
				echo "	-a/--all - activate all keys"
				echo "	-n/--name= - activates a key with specified name"
				echo "	--help - prints this message"
				return 0
			end

			if set -q _flag_all
				ssh-add ~/.ssh/keys/*
				return 0
			end

			if set -q _flag_name
				if not test -f ~/.ssh/keys/"$_flag_name"
					echo "Key with name: '$_flag_name' doesn't exist"
					return 2
				end
				ssh-add ~/.ssh/keys/"$_flag_name"
				return 0
			end

			echo "sshu up:"
			echo "	-a/--all - activate all keys"
			echo "	-n/--name= - activates a key with specified name"
			echo "	--help - prints this message"
			return 1

		case down
			argparse n/name= a/all help -- $args

			if set -q _flag_help
				echo "sshu down:"
				echo "	-a/--all - deactivate all keys"
				echo "	-n/--name= - deactivates a key with specified name"
				echo "	--help - prints this message"
				return 0
			end

			if set -q _flag_all
				ssh-add -D
				return 0
			end

			if set -q _flag_name
				ssh-add -d ~/.ssh/keys/"$_flag_name"
				return 0
			end

			echo "sshu down:"
			echo "	-a/--all - deactivate all keys"
			echo "	-n/--name= - deactivates a key with specified name"
			echo "	--help - prints this message"
			return 1

		case getpub
			set -l name $args[1]

			if test -z "$name"
				echo "Usage: sshu getpub name - prints the public key with name: 'name' to stdout"
				return 1
			end

			if not test -f ~/.ssh/keys/"$name"
				echo "Key with name '$name' doesn't exist"
				return 2
			end

			cat ~/.ssh/pubkeys/"$name".pub
		case '*'
			echo "sshu gen|del|up|down|list|getpub"
	end
end
