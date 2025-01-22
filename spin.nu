swaymsg move position center

while true {

    for i in 1..600 {
    swaymsg move left 1px
    if $i mod 2 == 0 {
      if $i < 300 {
        swaymsg move up 1px
      } else {
        swaymsg move down 1px
      }
      }
    sleep 5ms
    }

    for i in 1..600 {
    swaymsg move right 1px
    if $i mod 2 == 0 {
      if $i  < 300 {
        swaymsg move down 1px
      } else {
        swaymsg move up 1px
      }
      }
    sleep 5ms
    }

    for i in 1..600 {
    swaymsg move right 1px
    if $i mod 2 == 0 {
      if $i  < 300 {
        swaymsg move up 1px
      } else {
        swaymsg move down 1px
      }
      }
    sleep 5ms
    }

    for i in 1..600 {
    swaymsg move left 1px
    if $i mod 2 == 0 {
      if $i  < 300 {
        swaymsg move down 1px
      } else {
        swaymsg move up 1px
      }
      }
    sleep 5ms
    }

  }
