start=$(cat ~/dotfiles/sway/scripts/.time)
end=$(date +%Hh%Mmin)
time=$(qalc -t "$end - $start" | sed -E 's/[ +]//g')
branch=$(git rev-parse --abbrev-ref HEAD) &&
issueid=$(echo "$branch" | awk -F '-' '{print $1}') &&
glab issue update "$issueid" -d "/spend $time"
