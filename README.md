# Unopinionated FZF for Fish 🐟

![GitHub Release](https://img.shields.io/github/v/release/y3owk1n/fish-fzf)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/y3owk1n/fish-x/ci.yml)
![GitHub License](https://img.shields.io/github/license/y3owk1n/fish-fzf)

Welcom to `fish-fzf`, an unopinionated fzf functions for your Fish shell. Bind FZF to your workflow with ease in Fish. This plugin provides just the functions so you can map them into however you want to use it.

- `_fzf_cmd_history` - Command history search with fzf.
- `_fzf_directory_picker` - Directory picker with fzf.
- `_fzf_file_picker` - File picker with fzf.

## Installation

First, install a proper version of these CLI dependencies:

| CLI       | Description                             |
| --------  | --------------------------------------- |
| [fish][]  | a modern shell                          |
| [fzf][]   | fuzzy finder that powers this plugin    |
| [fd][]    | faster, colorized alternative to `find` |
| [bat][]   | smarter `cat` with syntax highlighting  |

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

#### Usage

```fish
_fzf_cmd_history [--prompt-name <custom_prompt>] [--allow-execute]
```

- Search and select commands from your command history using fzf.
- Replace the current command line with the selected command.
- Optionally, execute the selected command immediately.

### 2. Directory Picker

#### Usage

```fish
_fzf_directory_picker [--recursive-depth <depth>] [--prompt-name <custom_prompt>] [--allow-cd] [path]
```

- Navigate and select directories using fzf.
- Optionally, change the current directory or replace the current token with the selected directory path.
- Supports recursive depth and custom prompts.

### 3. File Picker

#### Usage

```fish
_fzf_file_picker [--show-hidden-files] [--prompt-name <custom_prompt>] [--allow-open-in-editor] [path]
```

- Browse and select files and directories using fzf.
- Optionally, open the selected file in your preferred editor or replace the current token with the selected file path.
- Supports showing hidden files, custom prompts, and opening in the editor.

## Customization

You can customize prompts and behaviors using command-line options.

Add these functions to your Fish configuration file to tailor them to your preferences.

### Examples

#### Command History

```fish
_fzf_cmd_history --prompt-name "Custom Prompt" --allow-execute
```

#### Directory Picker

```fish
_fzf_directory_picker --recursive-depth 2 --prompt-name "Choose Directory" --allow-cd /path/to/start
```

#### File Picker

```fish
_fzf_file_picker --show-hidden-files --prompt-name "Select File" --allow-open-in-editor /path/to/start
```

## Troubleshooting

If you encounter any issues or errors, please refer to the ~~troubleshooting section in the wiki~~ (Not ready yet).

## Contributions

Feel free to contribute by opening issues, suggesting enhancements, or submitting pull requests. We value your feedback and ideas to enhance the capabilities of `fish-fzf` further!

## License

This plugin is licensed under the MIT License. Feel free to use, modify, and distribute it as you see fit.

Happy fishing! 🐟
