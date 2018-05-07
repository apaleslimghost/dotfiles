function __git_upstream_configured
    git rev-parse --abbrev-ref @"{u}" > /dev/null 2>&1
end

function __quarterto_git_info
    if git_is_repo
        set -l branch_name (git_branch_name)

        if git_is_touched
            if git_is_staged
                print_color green "✓"
            end

            if git_is_dirty
                print_color yellow "✱"
            end
        end

        if test (git_untracked_files) -ne 0
            print_color cyan "⎘"
        end

        set -l git_ahead (git_ahead)
        switch "$git_ahead"
            case '+'
                print_color blue "⇡"
            case '-'
                print_color blue "⇣"
            case '±'
                print_color red "↯"
            case ''
        end

        print_color magenta " ⎇ $branch_name"
    end
end

function fish_right_prompt
    set -l status_copy $status
    set -l status_color red

    __quarterto_git_info

    if test "$CMD_DURATION" -gt 500
        set -l duration_copy $CMD_DURATION
        set -l duration (echo $CMD_DURATION | humanize_duration)

         print_color yellow " ◷$duration"
    end

    if test "$status_copy" -ne 0
        print_color $status_color " ⏎ $status_copy"
    end
end
