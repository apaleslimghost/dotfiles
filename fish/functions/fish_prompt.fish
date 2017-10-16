function fish_prompt -d "Simple Fish Prompt"
    set -l status_copy $status
    echo -e ""

    # User & host, if ssh
    if set --query SSH_CLIENT
        set -l user (id -un $USER)
        set -l host_name (hostname -s)

        print_color cyan "$user"
        print_color grey "@"
        print_color yellow "$host_name "
    end

    # Current working directory
    set -l pwd_string (echo $PWD | sed 's|^'$HOME'\(.*\)$|~\1|')

    print_color green "$pwd_string"

    set -l prompt_color brcyan

    if test "$status_copy" -ne 0
        set prompt_color red
    end

    set -l prompt_char "⟩"

    print_color $prompt_color " $prompt_char "
end
