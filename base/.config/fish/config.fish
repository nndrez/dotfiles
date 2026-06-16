if status is-interactive
    fnm env --use-on-cd --shell fish | source

    abbr -a o xdg-open
    abbr -a copy wl-copy

    function op
        set file (fzf)
        if test -n "$file"
            nohup xdg-open "$file" >/dev/null 2>&1 &
        end
    end
end

function fish_greeting
    fastfetch -l none
end
