function op --description "Fuzzy find a file and open it with xdg-open"
    if not type -q fzf
        echo "op: fzf is not installed" >&2
        return 1
    end

    set -l file (fzf)
    if test -n "$file"
        xdg-open "$file" >/dev/null 2>&1 &
        disown
    end
end
