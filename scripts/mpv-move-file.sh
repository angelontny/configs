#!/usr/bin/env bash
set -eo pipefail

FILE_TO_MOVE="$1"

if [[ -z "$FILE_TO_MOVE" || ! -e "$FILE_TO_MOVE" ]]; then
    echo "Error: No valid file provided to move."
    echo "Path received: '$FILE_TO_MOVE'"
    read -rp "Press Enter to exit..."
    exit 1
fi

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/mpv"
mkdir -p "$STATE_DIR"
STATE_FILE="$STATE_DIR/last_move_dir"

# Start at last selected directory or fallback to $HOME/Videos or $HOME
if [[ -f "$STATE_FILE" ]] && [[ -d "$(cat "$STATE_FILE")" ]]; then
    CURRENT_DIR="$(cat "$STATE_FILE")"
else
    CURRENT_DIR="${XDG_VIDEOS_DIR:-$HOME/Videos}"
    [[ ! -d "$CURRENT_DIR" ]] && CURRENT_DIR="$HOME"
fi

FILENAME="$(basename "$FILE_TO_MOVE")"

while true; do
    # Gather subdirectories (up to 3 levels, ignore hidden dirs)
    DIRS=()
    while IFS= read -r dir; do
        [[ -n "$dir" ]] && DIRS+=("$dir")
    done < <(find -L "$CURRENT_DIR" -maxdepth 3 -mindepth 1 -name '.*' -prune -o -type d -print 2>/dev/null | sed "s|^$CURRENT_DIR/||" | sort)

    # Build options list
    CHOICES=(
        "./ (MOVE TO CURRENT FOLDER)"
        "../ (go up)"
    )
    if [[ ${#DIRS[@]} -gt 0 ]]; then
        CHOICES+=("${DIRS[@]}")
    fi

    SELECTION=$(printf '%s\n' "${CHOICES[@]}" | fzf \
        --header="Moving: $FILENAME
Dir:    $CURRENT_DIR
-------------------------------------------------------------------------------
[Enter]: Select & Move  | [Tab]: Navigate inside  | [Left/Shift-Tab]: Go Up
[Ctrl+N]: Create Folder | [Esc]: Cancel" \
        --expect="tab,left,shift-tab,ctrl-n" \
        --height="100%" \
        --reverse \
        --prompt="folder > ")

    KEY=$(head -1 <<< "$SELECTION")
    ITEM=$(tail -n +2 <<< "$SELECTION")

    # Esc / Cancel
    if [[ -z "$KEY" && -z "$ITEM" ]]; then
        echo "Cancelled."
        exit 1
    fi

    # Create new folder on the fly
    if [[ "$KEY" == "ctrl-n" ]]; then
        echo ""
        read -rp "Enter new folder name (in $CURRENT_DIR): " NEW_FOLDER
        if [[ -n "$NEW_FOLDER" ]]; then
            TARGET="$CURRENT_DIR/$NEW_FOLDER"
            mkdir -p "$TARGET"
            CURRENT_DIR="$TARGET"
        fi
        continue
    fi

    # Navigate up
    if [[ "$KEY" == "left" || "$KEY" == "shift-tab" || "$ITEM" == "../ (go up)" ]]; then
        PARENT_DIR="$(dirname "$CURRENT_DIR")"
        if [[ -d "$PARENT_DIR" ]]; then
            CURRENT_DIR="$PARENT_DIR"
        fi
        continue
    fi

    # Navigate into subfolder with Tab
    if [[ "$KEY" == "tab" ]]; then
        if [[ -n "$ITEM" && "$ITEM" != "./ (MOVE TO CURRENT FOLDER)" && "$ITEM" != "../ (go up)" ]]; then
            TARGET="$CURRENT_DIR/$ITEM"
            if [[ -d "$TARGET" ]]; then
                CURRENT_DIR="$TARGET"
            fi
        fi
        continue
    fi

    # Enter pressed -> select directory and execute move
    if [[ "$KEY" == "" ]]; then
        if [[ "$ITEM" == "./ (MOVE TO CURRENT FOLDER)" ]]; then
            TARGET_DIR="$CURRENT_DIR"
        elif [[ "$ITEM" == "../ (go up)" ]]; then
            CURRENT_DIR="$(dirname "$CURRENT_DIR")"
            continue
        elif [[ -n "$ITEM" ]]; then
            TARGET_DIR="$CURRENT_DIR/$ITEM"
        else
            continue
        fi

        if [[ ! -d "$TARGET_DIR" ]]; then
            echo "Error: Directory '$TARGET_DIR' does not exist."
            sleep 1.5
            continue
        fi

        # Save state
        echo "$TARGET_DIR" > "$STATE_FILE"

        echo ""
        echo "Moving: $FILENAME"
        echo "To:     $TARGET_DIR/"
        
        if mv -v "$FILE_TO_MOVE" "$TARGET_DIR/"; then
            echo "Successfully moved!"
            sleep 0.6
            exit 0
        else
            echo "Error moving file!"
            read -rp "Press Enter to close..."
            exit 1
        fi
    fi
done
