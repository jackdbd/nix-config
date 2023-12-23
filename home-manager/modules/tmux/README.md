# tmux

Configuration for Tmux and Tmux plugins.

## tmux-resurrect

The tmux environment is saved to `~/.tmux/resurrect`, [unless configured otherwise](https://github.com/tmux-plugins/tmux-resurrect/blob/cff343cf9e81983d3da0c8562b01616f12e8d548/docs/save_dir.md).

Not all programs can be restored, and must be configured with the `@resurrect-processes` option as [described here](https://github.com/tmux-plugins/tmux-resurrect/blob/cff343cf9e81983d3da0c8562b01616f12e8d548/docs/restoring_programs.md).

Consider using a [save/restore hook](https://github.com/tmux-plugins/tmux-resurrect/blob/cff343cf9e81983d3da0c8562b01616f12e8d548/docs/hooks.md).

This plugin does not restore the shell history for each pane. See [here for a workaround](https://github.com/tmux-plugins/tmux-resurrect/blob/cff343cf9e81983d3da0c8562b01616f12e8d548/docs/restoring_bash_history.md).

See also [how to restore vim and neovim sessions](https://github.com/tmux-plugins/tmux-resurrect/blob/cff343cf9e81983d3da0c8562b01616f12e8d548/docs/restoring_vim_and_neovim_sessions.md).

## tmux-continuum

Set `@continuum-boot` and `@continuum-systemd-start-cmd` if you want to let a systemd service start the tmux server at system startup. See [here](https://github.com/tmux-plugins/tmux-continuum/blob/master/docs/systemd_details.md) and [here](https://github.com/tmux-plugins/tmux-continuum/blob/master/docs/automatic_start.md) for how to do it.

## Resources

- [TheCedarPrince's tmux configuration](https://gist.github.com/TheCedarPrince/07f6f8f79b1451ec436ff8dee236ccdd)
- [gvolpe's tmux configuration](https://github.com/gvolpe/nix-config/tree/master/home/programs/tmux)
- [iAmMrinal0's tmux configuration](https://github.com/iAmMrinal0/nix-config/blob/master/config/tmux.nix)
- [tmuxp](https://github.com/tmux-python/tmuxp): define tmux sessions in YAML files.
- [catppuccin theme](https://github.com/catppuccin/tmux)
- [dracula theme](https://github.com/dracula/tmux)
- [nord theme](https://github.com/nordtheme/tmux)
- [tmux-themes](https://github.com/topics/tmux-themes)
- [awesome-tmux](https://github.com/rothgar/awesome-tmux)
