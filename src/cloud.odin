package main

import "core:math/rand"
import rl "vendor:raylib"

@(private = "file")
MIN_SPEED :: 25.0
@(private = "file")
MAX_SPEED :: 100.0
@(private = "file")
MIN_Y :: 50.0
@(private = "file")
MAX_Y :: 200.0

Cloud :: struct {
	texture: ^rl.Texture,
	x:       f32,
	y:       f32,
	speed:   f32,
}

cloud_init :: proc(texture: ^rl.Texture) -> Cloud {
	x := rand.float32_range(0, 1920)
	y := rand.float32_range(MIN_Y, MAX_Y)
	speed := rand.float32_range(MIN_SPEED, MAX_SPEED)

	return Cloud{texture, x, y, speed}
}

cloud_update :: proc(cloud: ^Cloud, delta_time: f32) {
	cloud.x += cloud.speed * delta_time
	if (cloud.x > 1920) {
		cloud.x = f32(-cloud.texture.width)
		cloud.y = rand.float32_range(MIN_Y, MAX_Y)
	}
}

cloud_draw :: proc(cloud: ^Cloud) {
	rl.DrawTexture(cloud.texture^, i32(cloud.x), i32(cloud.y), rl.WHITE)
}

clouds_init :: proc(texture: ^rl.Texture, all_clouds: []Cloud) {
	for _, i in all_clouds {
		all_clouds[i] = cloud_init(texture)
	}
}
