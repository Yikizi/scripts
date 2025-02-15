def --wrapped main [
  --global (-g),
  cmd: string,
  ...rest,
] {
  if ($global) {
    $env.MY_STATE = "global"
  } else {
    $env.MY_STATE = "local"
  }
  match $cmd {
    "sub" => { sub ...$rest }
    "status" => { status }
  }
}

def sub [...args] {
  print $"State is currently: ($env.MY_STATE)"
  print $args
}

def status [] {
  print "status report"
  print $env.MY_STATE
}
