# Function to set up mocked history
function setup_mocked_history
    function history
        echo command1
        echo command2
        echo command3
        echo command4
        echo command5
    end
end

# Function to set up a mocked fzf function
function setup_mocked_fzf
    set -gx FZF_PROMPT_NAME ""
    function fzf
        set -gx FZF_PROMPT_NAME $argv[1]
        echo selected_command
    end
end

# Test _fzf_cmd_history without options
setup_mocked_history
set selected_command (echo "command1" | _fzf_cmd_history)
@test "selected command is correct" $selected_command = command1

# Test _fzf_cmd_history with custom prompt name
setup_mocked_history
set selected_command (echo "command2" | _fzf_cmd_history --prompt-name "CustomPrompt")
@test "selected command is correct with custom prompt name" $selected_command = command2
@test "prompt name in fzf is correct" $FZF_PROMPT_NAME = CustomPrompt

# Test _fzf_cmd_history with allow-execute option
setup_mocked_history
setup_mocked_fzf
set selected_command (echo "command3" | _fzf_cmd_history --allow-execute)
@test "selected command is correct with allow-execute option" $selected_command = command3
@test "prompt name in fzf is correct" $FZF_PROMPT_NAME = "Command History"

# Test _fzf_cmd_history with both prompt name and allow-execute options
setup_mocked_history
setup_mocked_fzf
set selected_command (echo "command4" | _fzf_cmd_history --prompt-name "CustomPrompt" --allow-execute)
@test "selected command is correct with both options" $selected_command = command4
@test "prompt name in fzf is correct" $FZF_PROMPT_NAME = CustomPrompt

# Test _fzf_cmd_history with allow-execute option (execution validation)
setup_mocked_history
set selected_command (echo "command5" | _fzf_cmd_history --allow-execute)
eval $selected_command
@test "command execution with allow-execute is successful" $status -eq 0
