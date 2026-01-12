package main

import "core:fmt"
import "core:os"
import "core:os/os2"
import "core:path/filepath"
import "core:strings"
import rl "vendor:raylib"

Game_Assets :: struct {
	axe:         rl.Texture2D,
	background:  rl.Texture2D,
	bee:         rl.Texture2D,
	branch:      rl.Texture2D,
	cloud:       rl.Texture2D,
	log:         rl.Texture2D,
	player:      rl.Texture2D,
	headstone:   rl.Texture2D,
	tree:        rl.Texture2D,
	tree_alt:    rl.Texture2D,
	death:       rl.Sound,
	out_of_time: rl.Sound,
	chop:        rl.Sound,
	font:        rl.Font,
}

get_asset_path :: proc(relative_path: string) -> cstring {
	exe_path, err := os2.get_executable_directory(context.allocator)
	defer delete(exe_path)
	if err != os2.General_Error.None {
		fmt.eprintfln("Error getting exe directory: %v", err)
		os.exit(-1)
	}

	os_path, allocated := filepath.from_slash(exe_path)
	if allocated {
		defer delete(os_path)
	}

	segments := [2]string{exe_path, relative_path}
	full_path, join_err := filepath.join(segments[:])
	defer delete(full_path)

	if join_err != .None {
		fmt.eprintfln("Error joining path segments: %v", err)
		os.exit(-1)
	}

	c_path, clone_err := strings.clone_to_cstring(full_path)
	if clone_err != .None {
		fmt.eprintfln("Error cloning string to cstring: %v", clone_err)
		os.exit(-1)
	}

	return c_path
}

load_assets :: proc() -> Game_Assets {
	axe_path := get_asset_path("assets/graphics/axe.png")
	defer delete(axe_path)

	background_path := get_asset_path("assets/graphics/background.png")
	defer delete(background_path)

	bee_path := get_asset_path("assets/graphics/bee.png")
	defer delete(bee_path)

	branch_path := get_asset_path("assets/graphics/branch.png")
	defer delete(branch_path)

	cloud_path := get_asset_path("assets/graphics/cloud.png")
	defer delete(cloud_path)

	log_path := get_asset_path("assets/graphics/log.png")
	defer delete(log_path)

	player_path := get_asset_path("assets/graphics/player.png")
	defer delete(player_path)

	headstone_path := get_asset_path("assets/graphics/rip.png")
	defer delete(headstone_path)

	tree_path := get_asset_path("assets/graphics/tree.png")
	defer delete(tree_path)

	tree_alt_path := get_asset_path("assets/graphics/tree2.png")
	defer delete(tree_alt_path)

	death_path := get_asset_path("assets/sounds/chop.wav")
	defer delete(death_path)

	out_of_time_path := get_asset_path("assets/sounds/out_of_time.wav")
	defer delete(out_of_time_path)

	chop_path := get_asset_path("assets/sounds/chop.wav")
	defer delete(chop_path)

	font_path := get_asset_path("assets/fonts/KOMIKAP_.ttf")
	defer delete(font_path)

	// Textures
	axe := rl.LoadTexture(axe_path)
	background := rl.LoadTexture(background_path)
	bee := rl.LoadTexture(bee_path)
	branch := rl.LoadTexture(branch_path)
	cloud := rl.LoadTexture(cloud_path)
	log := rl.LoadTexture(log_path)
	player := rl.LoadTexture(player_path)
	headstone := rl.LoadTexture(headstone_path)
	tree := rl.LoadTexture(tree_path)
	tree_alt := rl.LoadTexture(tree_alt_path)

	// Sounds
	death := rl.LoadSound(death_path)
	out_of_time := rl.LoadSound(out_of_time_path)
	chop := rl.LoadSound(chop_path)

	// Fonts
	font := rl.LoadFont(font_path)

	return Game_Assets {
		axe,
		background,
		bee,
		branch,
		cloud,
		log,
		player,
		headstone,
		tree,
		tree_alt,
		death,
		out_of_time,
		chop,
		font,
	}
}

unload_assets :: proc(assets: ^Game_Assets) {
	rl.UnloadTexture(assets.axe)
	rl.UnloadTexture(assets.background)
	rl.UnloadTexture(assets.bee)
	rl.UnloadTexture(assets.branch)
	rl.UnloadTexture(assets.cloud)
	rl.UnloadTexture(assets.log)
	rl.UnloadTexture(assets.player)
	rl.UnloadTexture(assets.headstone)
	rl.UnloadTexture(assets.tree)
	rl.UnloadTexture(assets.tree_alt)
	rl.UnloadSound(assets.death)
	rl.UnloadSound(assets.out_of_time)
	rl.UnloadSound(assets.chop)
	rl.UnloadFont(assets.font)
}
