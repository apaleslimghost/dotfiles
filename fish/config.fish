set fish_greeting ""
set fish_color_normal white # the default color
set fish_color_command green # the color for commands
set fish_color_quote yellow # the color for quoted blocks of text
set fish_color_redirection brgrey # the color for IO redirections
set fish_color_end brgrey # the color for process separators like ';' and '&'
set fish_color_error red # the color used to highlight potential errors
set fish_color_param cyan # the color for regular command parameters
set fish_color_comment grey # the color used for code comments
set fish_color_match blue # the color used to highlight matching parenthesis
set fish_color_search_match # the color used to highlight history search matches
set fish_color_operator grey # the color for parameter expansion operators like '*' and '~'
set fish_color_escape magenta # the color used to highlight character escapes like '\n' and '\x70'
set fish_color_autosuggestion brgrey # the color used for autosuggestions
set fish_color_cancel grey # the color for the '^C' indicator on a canceled command

# TODO: do this in a fishier way
set -x VAULT_ADDR https://vault.in.ft.com
set -x VAULT_AUTH_GITHUB_TOKEN (security find-generic-password -a $USER -s "FT Vault" -w)

# fundle plugin 'fisherman/git_util'
# fundle plugin 'fisherman/humanize_duration'
# fundle plugin 'fisherman/last_job_id'
# fundle plugin 'fisherman/menu'
# fundle plugin 'fisherman/get_file_age'
# fundle plugin 'fisherman/await'
# fundle plugin 'jorgebucaran/fish-nvm'
# fundle plugin 'rbenv/fish-rbenv'
# fundle plugin 'quarterto/check_git_status' --url 'quarterto/check_git_status'

# fundle init

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish


