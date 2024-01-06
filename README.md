# Unopinionated FZF for Fish 🐟

![GitHub Release](https://img.shields.io/github/v/release/y3owk1n/fish-fzf)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/y3owk1n/fish-x/ci.yml)
![GitHub License](https://img.shields.io/github/license/y3owk1n/fish-fzf)

Welcome to `fish-fzf`, an unopinionated fzf functions for your Fish shell. Bind FZF to your workflow with ease in Fish. This plugin provides just the functions so you can map them into however you want to use it.

- `_fzf_cmd_history` - Command history search with fzf.
- `_fzf_directory_picker` - Directory picker with fzf.
- `_fzf_file_picker` - File picker with fzf.

> I don't like to have unused keymaps that comes with most plugins. That's why `fish-fzf` exists.

## Roadmap

- [ ] New function for live grep

## Installation

First, install a proper version of these CLI dependencies:

| CLI       | Description                             |
| --------  | --------------------------------------- |
| [fish](https://fishshell.com/)  | a modern shell                          |
| [fzf](https://github.com/junegunn/fzf)   | fuzzy finder that powers this plugin    |
| [fd](https://github.com/sharkdp/fd)    | faster, colorized alternative to `find` |
| [bat](https://github.com/sharkdp/bat)   | smarter `cat` with syntax highlighting  |

### Using Nix's Home Manager (Recommended)

```fish
{
    programs.fish = {
        enable = true;
        plugins = [
            {
                name = "fish-fzf";
                src = pkgs.fetchFromGitHub {
                    owner = "y3owk1n";
                    repo = "fish-fzf";
                    rev = "v1.0.0";
                    sha256 = "generated-sha-256-values";
                };
            }
        ];
    };
}
```

### Using Fisher

```fish
fisher install y3owk1n/fish-fzf
```

### Manually

1. Clone this repository:

```fish
git clone https://github.com/y3owk1n/fish-fzf.git
```

2. Source the all the functions/*.fish file in your Fish configuration:

```fish
source /path/to/_fzf_cmd_history.fish
source /path/to/_fzf_directory_picker.fish
source /path/to/_fzf_file_picker.fish
source /path/to/_fzf_preview_cmd.fish
source /path/to/_fzf_preview_name.fish
```

## Features

### 1. Command History Search

- Search and select commands from your command history using fzf.
- Replace the current command line with the selected command.
- Optionally, execute the selected command immediately.

#### Usage

```fish
_fzf_cmd_history [--allow-execute] [--prompt-name <custom_prompt>]
```

- `--allow-execute` (optional) - Execute the selected command immediately on select.
- `--prompt-name` (optional) - Custom prompt to display in fzf.

### 2. Directory Picker

- Navigate and select directories using fzf.
- Optionally, change the current directory or replace the current token with the selected directory path.
- Supports recursive depth and custom prompts.

#### Usage

```fish
_fzf_directory_picker [--allow-cd] [--recursive-depth <depth>] [--prompt-name <custom_prompt>]  [path]
```

- `--allow-cd` (optional) - Change the current directory using the selected directory path.
- `--recursive-depth` (optional) - Depth to recursively search for directories. Defaults to 1.
- `--prompt-name` (optional) - Custom prompt to display in fzf.
- `path` (optional) - Directory path to start in. Defaults to '.'

### 3. File Picker

- Browse and select files and directories using fzf.
- By default, it respects .gitignore and you can turn `--show-hidden-files` for searching all files.
- Optionally, open the selected file in your preferred editor or replace the current token with the selected file path.
- Supports showing hidden files, custom prompts, and opening in the editor.

#### Usage

```fish
_fzf_file_picker [--allow-open-in-editor]  [--show-hidden-files] [--prompt-name <custom_prompt>] [path]
```

- `--allow-open-in-editor` (optional) - Open the selected file in your preferred editor.
- `--show-hidden-files` (optional) - Show hidden files.
- `--prompt-name` (optional) - Custom prompt to display in fzf.
- `path` (optional) - File path to start in. Defaults to '.'

##### Notes

Before using `--allow-open-in-editor`, ensure that your preferred editor is set in the **$EDITOR** environment variable. You can set it using:

```fish
set -Ux EDITOR nvim # vim, code, emacs, etc.
```

## Customization

You can customize prompts and behaviors using command-line options.

Add these functions to your Fish configuration file to tailor them to your preferences.

### Examples

#### Command History

```fish
_fzf_cmd_history --allow-execute --prompt-name "Custom Prompt" 
```

#### Directory Picker

```fish
_fzf_directory_picker --allow-cd --recursive-depth 2 --prompt-name "Choose Directory" /path/to/start
```

#### File Picker

```fish
_fzf_file_picker --allow-open-in-editor --show-hidden-files --prompt-name "Select File" /path/to/start
```

> Remember, these are just functions in fish shell. You can do whatever you want with them.

#### Make an alias / abbr and execute them on the fly

##### Abbr (I'm using this method)

```fish
# ~/.config/fish/config.fish

abbr --add --global -- fpc '_fzf_cmd_history --allow-execute' # Open up command history picker and allow execute on select.
abbr --add --global -- fpf '_fzf_file_picker --allow-open-in-editor --prompt-name Files' # Open up file picker in current directory, change the prompt name to 'Files' and open in editor on select.
abbr --add --global -- fpfh '_fzf_file_picker --allow-open-in-editor --show-hidden-files --prompt-name Files+' # Same as above but show hidden files.
abbr --add --global -- fpp '_fzf_directory_picker --allow-cd --prompt-name Projects ~/Dev/' # Open up directory picker in ~/Dev/ with default 1 level of recursive-depth and auto cd on select.
```

##### Alias

```fish
# ~/.config/fish/config.fish

alias fpc '_fzf_cmd_history --allow-execute'
alias fpf '_fzf_file_picker --allow-open-in-editor --prompt-name Files'
alias fpfh '_fzf_file_picker --allow-open-in-editor --show-hidden-files --prompt-name Files+'
alias fpp '_fzf_directory_picker --allow-cd --prompt-name Projects ~/Dev/'
````

#### Bind it with fish key bindings

```fish
# ~/.config/fish/functions/fish_user_key_bindings.fish

function fish_user_key_bindings
    bind \cg '_fzf_cmd_history --allow-execute'
    bind -M insert \cg `_fzf_cmd_history --allow-execute`
end
```

## Troubleshooting

If you encounter any issues or errors, please refer to the ~~troubleshooting section in the wiki~~ (Not ready yet).

## Contributions

Feel free to contribute by opening issues, suggesting enhancements, or submitting pull requests. We value your feedback and ideas to enhance the capabilities of `fish-fzf` further!

## License

This plugin is licensed under the MIT License. Feel free to use, modify, and distribute it as you see fit.

Happy fishing! 🐟
