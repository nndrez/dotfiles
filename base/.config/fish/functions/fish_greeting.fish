function fish_greeting --description "Display welcome message using fastfetch if available"
    if type -q fastfetch
        fastfetch -l none
    end
end
