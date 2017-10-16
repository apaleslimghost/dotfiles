function atom
    if test (command -s atom-beta) != ""
        atom-beta $argv
    else
        atom $argv
    end
end