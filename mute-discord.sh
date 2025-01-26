#!/bin/bash

swaymsg '[class="WebCord"]' focus &&
  wtype -M ctrl -M shift m -m ctrl -m shift &&
  swayr switch-to-urgent-or-lru-window --skip-urgent
