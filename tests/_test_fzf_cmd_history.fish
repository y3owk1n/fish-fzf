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

# Variable to capture the output of _fzf_cmd_history
set selected_command_output

# Function to override echo and capture the output
function echo -e
    set selected_command_output $argv[1]
end

# Test _fzf_cmd_history without options
setup_mocked_history
set selected_command (echo "command1" | _fzf_cmd_history)
set selected_command_without_equals (string replace '=' '' $selected_command_output)
@test "selected command is correct" "$selected_command_without_equals" = command1

# Test _fzf_cmd_history with custom prompt name
setup_mocked_history
set selected_command (echo "command2" | _fzf_cmd_history --prompt-name "CustomPrompt")
set selected_command_without_equals (string replace '=' '' $selected_command_output)
@test "selected command is correct with custom prompt name" "$selected_command_without_equals" = command2
@test "prompt name in fzf is correct" $FZF_PROMPT_NAME = CustomPrompt

# Test _fzf_cmd_history with allow-execute option
setup_mocked_history
setup_mocked_fzf
set selected_command (echo "command3" | _fzf_cmd_history --allow-execute)
set selected_command_without_equals (string replace '=' '' $selected_command_output)
@test "selected command is correct with allow-execute option" "$selected_command_without_equals" = command3
@test "prompt name in fzf is correct" $FZF_PROMPT_NAME = "Command History"

# Test _fzf_cmd_history with both prompt name and allow-execute options
setup_mocked_history
setup_mocked_fzf
set selected_command (echo "command4" | _fzf_cmd_history --prompt-name "CustomPrompt" --allow-execute)
set selected_command_without_equals (string replace '=' '' $selected_command_output)
@test "selected command is correct with both options" "$selected_command_without_equals" = command4
@test "prompt name in fzf is correct" $FZF_PROMPT_NAME = CustomPrompt

# Test _fzf_cmd_history with allow-execute option (execution validation)
setup_mocked_history
set selected_command (echo "command5" | _fzf_cmd_history --allow-execute)
eval $selected_command
@test "command execution with allow-execute is successful" $status -eq 0
