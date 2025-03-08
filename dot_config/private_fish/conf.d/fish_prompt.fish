function fish_prompt
    set -l last_status $status

    set -l normal (set_color normal)

    echo -n (hostname)' '

    echo -n (set_color $fish_color_cwd)(prompt_pwd)$normal

    # Show git status if we're in a git repository
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        # Get current branch name
        set -l git_branch (git symbolic-ref --short HEAD 2>/dev/null; or git describe --tags --exact-match 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)

        # Check if there are any changes
        if git diff-index --quiet HEAD -- 2>/dev/null
            # Clean repository - use the same color as commands
            echo -n " "(set_color $fish_color_command)"("$git_branch")"$normal
        else
            # Dirty repository - use the color for warnings
            echo -n " "(set_color $fish_color_warning)"("$git_branch"*)"$normal
        end
    end

    echo -n " "

    if test $last_status -eq 0
        echo -n '❯ '
    else
        echo -n (set_color $fish_color_error)'$ '$normal
    end
end
