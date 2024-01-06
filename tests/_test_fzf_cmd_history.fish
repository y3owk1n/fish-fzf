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

# Temporary directory to store output file
set temp_dir (mktemp -d)
set output_file $temp_dir/output.txt

# Test _fzf_cmd_history without options
setup_mocked_history
echo command1 | _fzf_cmd_history >$output_file

set selected_command_without_equals (string replace '=' '' (cat $output_file))
@test "selected command is correct" "$selected_command_without_equals" = command1

# Test _fzf_cmd_history with custom prompt name
setup_mocked_history
setup_mocked_fzf
echo command2 | _fzf_cmd_history --prompt-name CustomPrompt >$output_file

set selected_command_without_equals (string replace '=' '' (cat $output_file))
@test "selected command is correct with custom prompt name" "$selected_command_without_equals" = command2
@test "prompt name in fzf is correct" $FZF_PROMPT_NAME = CustomPrompt

# Test _fzf_cmd_history with allow-execute option
setup_mocked_history
setup_mocked_fzf
echo command3 | _fzf_cmd_history --allow-execute >$output_file

set selected_command_without_equals (string replace '=' '' (cat $output_file))
@test "selected command is correct with allow-execute option" "$selected_command_without_equals" = command3
@test "prompt name in fzf is correct" $FZF_PROMPT_NAME = "Command History"

# Test _fzf_cmd_history with both prompt name and allow-execute options
setup_mocked_history
setup_mocked_fzf
echo command4 | _fzf_cmd_history --prompt-name CustomPrompt --allow-execute >$output_file

set selected_command_without_equals (string replace '=' '' (cat $output_file))
@test "selected command is correct with both options" "$selected_command_without_equals" = command4
@test "prompt name in fzf is correct" $FZF_PROMPT_NAME = CustomPrompt

# Test _fzf_cmd_history with allow-execute option (execution validation)
setup_mocked_history
echo command5 | _fzf_cmd_history --allow-execute >$output_file
eval (cat $output_file)
@test "command execution with allow-execute is successful" $status -eq 0

# Clean up temporary directory
rm -rf $temp_dir
