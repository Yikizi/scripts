#!/usr/bin/env -S nu --stdin

def main [] {
  print "Taskwarrior cli wrapper"
  print "(l) for list of tasks"
  print "(a) to add a task"
  print "(d) to complete a task"
  print "(q) to quit"
  mut key = ""
  loop {
    $key = (input listen | get code)
    match $key {
      l => { list }
      a => { add }
      d => { pick (refresh) }
      q => { exit 0 }
    }
  }
}

def pick [data] {
  let selected = ($data | input list)
  task ($selected | get id) done
  print $"($selected | get description) deleted!"
}

def refresh [] {
  task export | from json | where id != 0 | select id description tags
}

def add [] {
  let description = (input "Description: ")
  let tags = (input "Tags: " | split words | each {|it| "+" + $it})
  task add $description ($tags | str join " " | str trim)
}

def list [] {
  task list
}
