#!/usr/bin/env nu

# NOTE: to get started, simply add a bookmark

use my-utils.nu fzf-launch
let path = $"($env.HOME)/dotfiles/sway/scripts/bookmarks.json"

def "bm add" [name: string] {
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

def "bm remove" [name: string] {
  open $path
  | where url != $name | collect
  | save -f $path
}

def "bm close" [
  --port (-p): string = "9222",
  --filter (-f): string = ""
] {
  let bookmarks = (open $path | get url)
  let tabs_json = (http get $"http://localhost:($port)/json/list"
    | where type == page)
  for tab in $tabs_json {
    if not ($tab.url | str contains $filter) { continue }
    if ($bookmarks | any {|it| $it == $tab.url} ) {
      http get $"http://localhost:($port)/json/close/($tab.id)"
    }
  }
}

def "bm open" [line: string] {
  let url = ($line | split column " " | get column1 | to text -n)
  if not (bm check-if-open $url) {
    vivaldi --new-tab $url # replace with your browser of choice
  }
  swaymsg '[app_id="vivaldi-stable"]' focus
  bm increment $url
}

def "bm check-if-open" [url: string] {
  let tabs = (http get "http://localhost:9222/json/list" | select url id)
  if ($tabs | any {|it| $it.url == $url}) {
    http get $"http://localhost:9222/json/activate/($tabs | where url == $url | get id | to text -n | str trim)"
    return true
  }
  return false
}

def "bm increment" [url: string] {
  open $path | each {|it|
    if $it.url == $url {
      let new_it = ($it | update clicks ($it.clicks + 1))
      $new_it
    } else {
      $it
    }
  } | collect | save -f $path
}

def "bm list" [] {
  let data = (open $path | sort-by clicks | reject clicks | to csv -s ' ' -n)
  let cmd = "fzf.sh --history=/home/mattias/history/bookmarks.fzf --preview='' --wrap --cycle --bind 'ctrl-t:execute(nu ~/dotfiles/sway/scripts/bookmarks.nu tag {}),enter:execute-silent(~/dotfiles/sway/scripts/bookmarks.nu open {})+abort,alt-e:execute(nvim ~/dotfiles/sway/scripts/bookmarks.json)'"
  fzf-launch $data $cmd
}

def "bm tag" [url: string] {
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

def bm [] {
  print "main function called"
}
