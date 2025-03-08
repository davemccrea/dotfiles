function wip 
    set current_date (date "+%Y-%m-%d %H:%M:%S")
    git add .
    git commit -m "WIP: $current_date"
end
