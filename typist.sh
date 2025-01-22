#!/bin/bash
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

init_term() {
    charCount=$(echo -n "$phrase" | awk -v FS="" '{print NF}')
    shopt -s checkwinsize; (:;:)
    ((startX=COLUMNS / 10 / 2 - charCount / 2))
    ((startY=LINES / 2))
    ((startX=startX < 0 ? 1 : startX + COLUMNS / 10))

    printf '\e[?1049h\e[2J\e[?25h\e[%d;%dH' "$startY" "$startX"
}

deinit_term() { printf '\e[?1049l\e[?25h'; }

draw_phrase() {
    local i="$startX" j="$startY"
    local -gA phraseChars
    local length=$(echo -n "$phrase" | wc -m)  # Count UTF-8 characters

    for ((k = 0; k < length; k++)); do
        char=$(echo -n "$phrase" | cut -c$((k + 1)))  # Extract character at position k+1

        if [[ "$char" == " " ]]; then
            # Handle spaces with proper wrapping
            if ((i + 1 > COLUMNS * 9 / 10)); then
                ((i = startX, j++))  # Wrap to next line
            fi
        fi

        phraseChars["$j;$i"]="$char"
        printf '\e[%d;%dH%s' "$j" "$i" "$char"  # Print character at position

        ((i++))
        if ((i > COLUMNS)); then
            ((i = startX, j++))
        fi
    done

    lineLen[j]="$i"
}

main() {

    if ((lineNum >= ${#lines[@]})); then
        printf '\e[%dHAll lines completed! Press [q] to quit.\n' "$LINES"
        exit 0
    fi

    phrase="${lines[$lineNum]}"
    ((lineNum++))
    [[ $lenline == "$lineNum" ]] && echo "Final line!"

    startX=$((COLUMNS / 2 - ${#phrase} / 2))
    startY=$((LINES / 2))
    startX=$((startX < 0 ? 0 : startX))

    printf '\e[2J'
    draw_phrase

    local i="$startX" j="$startY" k=0 matched=0 startTime="$EPOCHSECONDS"
    printf '\e[%d;%dH' "$j" "$i"

    while IFS= read -rsN1 char; do
        (( DEBUG )) && printf '\e[%dHDEBUG: j=%d i=%d k=%d m=%d' \
            "$LINES" "$j" "$i" "$k" "$matched"

        [[ $char == $'\n' ]]&& break
        case $char in
            $'\x7f')
                (( i <= startX ? j <= startY || (j--, i=lineLen[j]) :
                    (i--, k--, (matched && matched--)) ))

                printf '\e[%d;%dH%c\e[D' "$j" "$i" "${phraseChars[$j;$i]}"
            ;;
            ' ')
                if [[ $char == "${phraseChars[$j;$i]}" ]]; then
                    printf '\e[%d;%dH\e[32m_\e[m' "$j" "$i"
                else
                    printf '\e[%d;%dH\e[31m_\e[m\e[A\e[D\e[1;7m%c\e[m\e[B' \
                        "$j" "$i" "${phraseChars[$j;$i]}"
                fi
                ((i++, k++, matched++))
            ;;
            "${phraseChars[$j;$i]}")
                printf '\e[%d;%dH\e[32m%c\e[m' "$j" "$i" "$char"
                ((i++, k++, matched++))
            ;;
            [aA-zZ]|[0-9])
                printf '\e[%d;%dH\e[31m%c\e[m\e[A\e[D\e[1;7m%c\e[m\e[B' \
                    "$j" "$i" "$char" "${phraseChars[$j;$i]}"

                [[ ${phraseChars[$j;$i]} == ' ' ]] && printf '\e[A\e[D\e[1;7m_\e[m\e[B'
                ((i++, k++))
            ;;
        esac

        (( i > lineLen[j] && (i=startX, j++) ))
        (( k >= ${#phraseChars[@]} )) && break
    done

    printf '\e[%dH\e[2K\e[?25lAccuracy: %s %s%%\nWPM: %s' \
        "$LINES" "$matched/${#phraseChars[@]}" \
        "$((matched * 100 / ${#phraseChars[@]}))" \
        "$((matched * 60 / 5 / (EPOCHSECONDS - startTime)))"
}

file="${1:-phrases.txt}"
mapfile -t lines < "$file"
lineNum="${2:-0}"
lenline=$(cat "$file" | wc -l)

trap deinit_term EXIT
trap 'exit 1' INT

init_term
main

while read -rsn1; do
    case $REPLY in
        [qQ]) break ;;
        [rR]) main ;;
    esac
done

