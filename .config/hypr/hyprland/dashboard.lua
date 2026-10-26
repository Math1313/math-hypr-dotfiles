local GAP = 10 -- espacement uniforme en pixels
local BAR_TOP = 10 -- hauteur de waybar si elle est en haut (px)
local BAR_BOTTOM = 0 -- hauteur de waybar si elle est en bas (px)

-- Largeur d'une colonne : (écran - 3 espaces) / 2
local COL_W = "((monitor_w - 3 * " .. GAP .. ") / 2)"
-- Hauteur disponible pour deux fenêtres empilées : écran - barre - 3 espaces
local COL_H = "(monitor_h - " .. (BAR_TOP + BAR_BOTTOM) .. " - 3 * " .. GAP .. ")"

local function dash_column(col, top_class, bottom_class, ratio)
	local x = GAP .. " + " .. col .. " * (" .. COL_W .. " + " .. GAP .. ")"
	local top_h = COL_H .. " * " .. ratio
	local bottom_h = COL_H .. " * " .. (1 - ratio)
	local top_y = tostring(BAR_TOP + GAP)
	local bottom_y = top_y .. " + " .. top_h .. " + " .. GAP

	local function rule(class, y, h)
		hl.window_rule({
			name = "dash-" .. class,
			match = { class = "^dash-" .. class .. "$" },
			workspace = "special:dashboard",
			float = true,
			move = { x, y },
			size = { COL_W, h },
		})
	end

	rule(top_class, top_y, top_h)
	rule(bottom_class, bottom_y, bottom_h)
end

--           colonne  haut         bas        part du haut
dash_column(0, "fastfetch", "arttime", 0.55)
dash_column(1, "animation", "btop", 0.35)
-- Super + D
hl.bind("SUPER + D", hl.dsp.workspace.toggle_special("dashboard"))

hl.on("hyprland.start", function()
	hl.exec_cmd("kitty --class dash-btop -o font_size=10 -e btop")
	hl.exec_cmd(
		[[kitty --class dash-fastfetch -o font_size=10 sh -c 'stty -echo; fastfetch; printf "\033[?25l"; exec sleep infinity']]
	)
	hl.exec_cmd(
		[[kitty --class dash-arttime -o font_size=10 arttime --theme light --nolearn -a worldmap -t "Welcome, Mathis"]]
	)
	hl.exec_cmd("kitty --class dash-animation -o font_size=10 ~/.config/hypr/scripts/loop-animation.py")
end)

hl.window_rule({
	name = "dashboard-windows",
	match = { class = "^(dash-.*)$" },
	workspace = "special:dashboard",
})

hl.config({
	binds = {
		hide_special_on_workspace_change = true,
	},
})

hl.workspace_rule({
	workspace = "special:dashboard",
	gaps_out = 10,
	gaps_in = 4,
})
