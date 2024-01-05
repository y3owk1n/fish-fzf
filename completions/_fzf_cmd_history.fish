# ~/.config/fish/completions/_fzf_cmd_history.fish

function __fzf_cmd_history_completion
    set -l cmd_history_options '--prompt-name --allow-execute'

    for opt in $cmd_history_options
        if string match -q -r -- "$opt*" (commandline --current-token)
            return
        end
    end

    # If none of the options matched, suggest all options
    echo $cmd_history_options
end

complete -c _fzf_cmd_history -f -n __fzf_cmd_history_completion -d 'fzf command history'
