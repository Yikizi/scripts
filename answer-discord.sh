#!/bin/bash

swaymsg '[class="WebCord"]' focus &&
  wtype -M ctrl -k return -m ctrl &&
  swayr switch-to-urgent-or-lru-window --skip-urgent
