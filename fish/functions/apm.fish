function apm
    if test (command -s apm-beta) != ""
        apm-beta $argv
    else
        apm $argv
    end
end
