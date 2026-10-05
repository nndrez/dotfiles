# Add local binaries to PATH (globally for this session, avoiding universal variable pollution)
fish_add_path -g ~/.local/bin

if status is-interactive
    if type -q fnm
        fnm env --use-on-cd --shell fish | source
    end

    abbr -a o xdg-open
    abbr -a copy wl-copy
end
