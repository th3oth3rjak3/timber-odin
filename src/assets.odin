package main

import "core:fmt"
import "core:os/os2"
import "core:path/filepath"
import "core:strings"
import rl "vendor:raylib"

// Game_Assets contains all the textures, fonts, and sounds
// required for the game.
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

// Load a texture by providing its bath path and its filename.
load_texture_from :: proc(base_path: string, filename: string) -> rl.Texture2D {
	full_path, join_err := filepath.join([]string{base_path, filename})
	if join_err != .None {
		panic(fmt.tprintf("FATAL: Could not join path for %s: %v", filename, join_err))
	}
	defer delete(full_path)

	path_cstring, clone_err := strings.clone_to_cstring(full_path)
	if clone_err != .None {
		panic(fmt.tprintf("FATAL: Could not convert path to cstring: %s", full_path))
	}
	defer delete(path_cstring)

	texture := rl.LoadTexture(path_cstring)
	return texture
}

// Load a font by providing its base path and its filename.
load_sound_from :: proc(base_path: string, filename: string) -> rl.Sound {
	full_path, join_err := filepath.join([]string{base_path, filename})
	if join_err != .None {
		panic(fmt.tprintf("FATAL: Could not join path for %s: %v", filename, join_err))
	}
	defer delete(full_path)

	path_cstring, clone_err := strings.clone_to_cstring(full_path)
	if clone_err != .None {
		panic(fmt.tprintf("FATAL: Could not convert path to cstring: %s", full_path))
	}
	defer delete(path_cstring)

	sound := rl.LoadSound(path_cstring)
	return sound
}

// Load a font by providing its base path and its filename.
load_font_from :: proc(base_path: string, filename: string) -> rl.Font {
	full_path, join_err := filepath.join([]string{base_path, filename})
	if join_err != .None {
		panic(fmt.tprintf("FATAL: Could not join path for %s: %v", filename, join_err))
	}
	defer delete(full_path)

	path_cstring, clone_err := strings.clone_to_cstring(full_path)
	if clone_err != .None {
		panic(fmt.tprintf("FATAL: Could not convert path to cstring: %s", full_path))
	}
	defer delete(path_cstring)

	font := rl.LoadFont(path_cstring)
	return font
}

// Load all game related assets.
load_assets :: proc() -> Game_Assets {
	exe_path, err := os2.get_executable_directory(context.allocator)
	if err != os2.General_Error.None {
		panic(fmt.tprintfln("FATAL: Failed to get executable path"))
	}
	defer delete(exe_path)

	assets_dir, _ := filepath.join([]string{exe_path, "assets"})
	defer delete(assets_dir)

	sounds_dir, _ := filepath.join([]string{assets_dir, "sounds"})
	defer delete(sounds_dir)

	graphics_dir, _ := filepath.join([]string{assets_dir, "graphics"})
	defer delete(graphics_dir)

	fonts_dir, _ := filepath.join([]string{assets_dir, "fonts"})
	defer delete(fonts_dir)

	return Game_Assets {
		axe = load_texture_from(graphics_dir, "axe.png"),
		background = load_texture_from(graphics_dir, "background.png"),
		bee = load_texture_from(graphics_dir, "bee.png"),
		branch = load_texture_from(graphics_dir, "branch.png"),
		cloud = load_texture_from(graphics_dir, "cloud.png"),
		log = load_texture_from(graphics_dir, "log.png"),
		player = load_texture_from(graphics_dir, "player.png"),
		headstone = load_texture_from(graphics_dir, "rip.png"),
		tree = load_texture_from(graphics_dir, "tree.png"),
		tree_alt = load_texture_from(graphics_dir, "tree2.png"),
		death = load_sound_from(sounds_dir, "death.wav"),
		out_of_time = load_sound_from(sounds_dir, "out_of_time.wav"),
		chop = load_sound_from(sounds_dir, "chop.wav"),
		font = load_font_from(fonts_dir, "KOMIKAP_.ttf"),
	}
}

// Unload all loaded assets.
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
