#!/bin/bash
copyq tab links read | grep -oE "https://[^ ]+" | xargs -I {} xdg-open {}
