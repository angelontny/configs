local mp = require 'mp'

local function move_current_file()
    local path = mp.get_property("path")
    if not path or path == "" then
        mp.osd_message("No file is currently playing", 2)
        return
    end

    -- Skip remote network streams/URLs
    if path:find("^%a+://") then
        mp.osd_message("Cannot move network streams/URLs", 2)
        return
    end

    -- Resolve relative path to absolute if needed
    local full_path = path
    if not path:find("^/") then
        local pwd = mp.get_property("working-directory", "")
        if pwd ~= "" then
            full_path = pwd .. "/" .. path
        end
    end

    -- Pause playback while selecting destination
    local was_paused = mp.get_property_bool("pause", false)
    mp.set_property_bool("pause", true)

    local script = os.getenv("HOME") .. "/.local/bin/mpv-move-file.sh"

    local cmd = {
        name = "subprocess",
        playback_only = false,
        capture_stdout = true,
        capture_stderr = true,
        args = {
            "alacritty",
            "--title", "mpv - Move File",
            "--class", "mpv-file-picker,mpv-file-picker",
            "-o", "window.dimensions.columns=90",
            "-o", "window.dimensions.lines=25",
            "-e", script, full_path
        }
    }

    mp.command_native_async(cmd, function(success, res, err)
        if res and res.status == 0 then
            mp.osd_message("File moved successfully!", 3)
            -- Advance to next playlist entry if more exist
            local playlist_pos = mp.get_property_number("playlist-pos", 0)
            local playlist_count = mp.get_property_number("playlist-count", 1)
            if playlist_pos + 1 < playlist_count then
                mp.command("playlist-next")
            else
                mp.osd_message("File moved (end of playlist)", 3)
            end
        else
            -- User cancelled or exit with non-zero: restore previous pause state
            mp.set_property_bool("pause", was_paused)
        end
    end)
end

-- Default keybinding: ctrl+m
-- Can be rebound in input.conf as: <KEY> script-binding move-file-interactive
mp.add_key_binding("ctrl+m", "move-file-interactive", move_current_file)
