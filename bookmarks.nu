#!/usr/bin/env nu

# NOTE: to get started, simply add a bookmark

let path = $"($env.HOME)/dotfiles/sway/scripts/bookmarks.json"

def "main add" [name: string] {
  let bookmark = {
    "url": $name,
    "clicks": 0,
    "tags": "",
  }
  open $path
  | append $bookmark
  | collect
  | save -f $path
}

def "main remove" [name: string] {
  open $path
  | where url != $name | collect
  | save -f $path
}

def "main open" [line: string] {
  let url = ($line | split column " " | get column1 | to text -n)
  vivaldi --new-tab $url # replace with your browser of choice
  swaymsg '[app_id="vivaldi-stable"]' focus
  main increment $url
}

def "main increment" [url: string] {
  open $path | each {|it|
    if $it.url == $url {
      let new_it = ($it | update clicks ($it.clicks + 1))
      $new_it
    } else {
      $it
    }
  } | collect | save -f $path
}

def "main list" [] {
  let data = (open $path | sort-by clicks | reject clicks | to csv -s ' ' -n)
  let cmd = "fzf --bind 'ctrl-t:execute(nu ~/dotfiles/sway/scripts/bookmarks.nu tag {}),enter:execute-silent(~/dotfiles/sway/scripts/bookmarks.nu open {})+abort'"
  foot -T fzf-launcher -e tmux -c $"echo '($data)' | ($cmd)"
}

def "main tag" [url: string] {
  let tag = (input "Tag: ")
  let url = ($url | split column " " | select 0 | get column1 | to text | str trim)
  open $path | each {|it|
    if $it.url == $url {
      let new_it = ($it | update tags ($it.tags + " " + $tag | str trim))
      $new_it
    } else {
      $it
    }
  } | collect | save -f $path
}

def main [] {
  print "main function called"
}
