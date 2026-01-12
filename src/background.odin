package main

import rl "vendor:raylib"

Background :: struct {
	texture: ^rl.Texture,
}

background_new :: proc(texture: ^rl.Texture) -> Background {
	return Background{texture}
}

background_draw :: proc(background: ^Background) {
	rl.DrawTexture(background.texture^, 0, 0, rl.WHITE)
}
