#!/bin/bash

swaymsg '[class="WebCord"]' focus &&
  wtype -M ctrl -M shift -k m &&
  swayr switch-to-urgent-or-lru-window --skip-urgent
