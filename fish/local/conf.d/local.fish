function __check_git_status_prompt
	print_color cyan (basename $PWD)

	if git_is_touched
		echo -n ' has'
		print_color yellow ' ✱ uncommitted changes'
	end

	set -l ahead (git_ahead)
	if test "$ahead" = "+" -o "$ahead" = "±"
		if git_is_touched
			echo -n ' and'
		else
			echo -n ' has'
		end

		if test "$ahead" = "+"
			print_color blue ' ⇡ unpushed commits'
		else
			print_color red ' ↯ diverged from upstream'
		end
	end

	echo -n '. Continue? '
end

function __check_git_status_post --on-event postcd
	if test $check_git_status_old_pwd
		builtin cd $check_git_status_old_pwd
		set -e check_git_status_old_pwd

		echo
		echo -n 'Staying in '
		print_color cyan (basename $PWD)
		echo '.'
		echo

		sleep 1

		git status
	end
end

function __check_git_status_in_same_repo
	if not git_is_repo
		return 1
	else
		set -l orig_repo (git rev-parse --show-toplevel)
		set -l old_dir $PWD

		builtin cd $argv[1]

		if not git_is_repo
			builtin cd $old_dir
			return 1
		else
			set -l next_repo (git rev-parse --show-toplevel)
			builtin cd $old_dir

			if test $orig_repo = $next_repo
				return 0
			else
				return 1
			end
		end
	end
end

function __check_git_status --on-event precd
	if git_is_repo; and not __check_git_status_in_same_repo $argv[1]
		set -l ahead (git_ahead)

		if git_is_touched; or test "$ahead" = "+" -o "$ahead" = "±"
			read --prompt=__check_git_status_prompt confirm

			if test $confirm = 'n'
				set -g check_git_status_old_pwd $PWD
			else
				set -e check_git_status_old_pwd
			end
		end
	end
end
