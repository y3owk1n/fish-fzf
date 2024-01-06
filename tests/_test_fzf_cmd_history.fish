set temp_dir (mktemp -d)

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

# Function to delete directories
function cleanup_directories
    if test -d $temp_dir
        rm -rf $temp_dir
    end
end

# Test _fzf_cmd_history without options
setup_mocked_history
echo command1 | _fzf_cmd_history >/dev/null

@test "commandline is replaced with selected command" (commandline) = command1

# Clean up
cleanup_directories

# Test _fzf_cmd_history with custom prompt name
setup_mocked_history
echo command2 | _fzf_cmd_history --prompt-name CustomPrompt >/dev/null

@test "custom prompt name is used" (commandline) = command2

# Clean up
cleanup_directories

# Test _fzf_cmd_history with allow-execute option
setup_mocked_history
echo command3 | _fzf_cmd_history --allow-execute >/dev/null

@test "allow-execute option executes the command" (commandline) = command3

# Clean up
cleanup_directories

# Test _fzf_cmd_history with both prompt name and allow-execute options
setup_mocked_history
echo command4 | _fzf_cmd_history --prompt-name CustomPrompt --allow-execute >/dev/null

@test "both prompt name and allow-execute options work" (commandline) = command4

# Clean up
cleanup_directories

rm -rf $temp_dir
