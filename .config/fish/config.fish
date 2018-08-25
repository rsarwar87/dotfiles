# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

     set -g theme_display_git yes
     set -g theme_display_git_dirty yes
     set -g theme_display_git_untracked yes
     set -g theme_display_git_ahead_verbose yes
     set -g theme_display_git_dirty_verbose yes
     set -g theme_display_git_master_branch yes
     set -g theme_git_worktree_support yes
     set -g theme_display_vagrant yes
     set -g theme_display_docker_machine no
     set -g theme_display_k8s_context yes
     set -g theme_display_hg yes
     set -g theme_display_virtualenv no
     set -g theme_display_ruby no
     set -g theme_display_user yes
     set -g theme_display_hostname yes
     set -g theme_display_vi yes
     set -g theme_avoid_ambiguous_glyphs yes
     set -g theme_powerline_fonts yes
     set -g theme_nerd_fonts yes
     set -g theme_show_exit_status no
#     set -g default_user your_normal_user
     set -g theme_color_scheme dracula 
     set -g fish_prompt_pwd_dir_length 0
     set -g theme_project_dir_length 1
     set -g theme_newline_cursor yes

function setenv; set -gx $argv; end
function setalias; alias $argv; end
source ~/.env

#
#
set -g __fish_git_prompt_show_informative_status 1
#set -g __fish_git_prompt_hide_untrackedfiles 1
#
#set -U fish_prompt_pwd_dir_length 0
#
#set -g __fish_git_prompt_color_branch magenta bold
#set -g __fish_git_prompt_showupstream "informative"
#set -g __fish_git_prompt_char_upstream_ahead "↑"
#set -g __fish_git_prompt_char_upstream_behind "↓"
#set -g __fish_git_prompt_char_upstream_prefix ""
#
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"
#
#set -g __fish_git_prompt_color_dirtystate blue
#set -g __fish_git_prompt_color_stagedstate yellow
#set -g __fish_git_prompt_color_invalidstate red
#set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
#set -g __fish_git_prompt_color_cleanstate green bold
#

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish
