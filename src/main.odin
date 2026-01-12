package main

import "core:mem"
import rl "vendor:raylib"

raylib_init :: proc() {
	when ODIN_DEBUG {
		rl.SetTraceLogLevel(rl.TraceLogLevel.ALL)
	}
	rl.InitWindow(1920, 1080, "Timber!!")
	rl.SetTargetFPS(60)
	rl.InitAudioDevice()
}

raylib_cleanup :: proc() {
	rl.CloseWindow()
	rl.CloseAudioDevice()
}

main :: proc() {
	// Courtesy of: https://glennyonemitsu.com/post/tracking-memory-leaks-in-odin.html
	when ODIN_DEBUG {
		tracker: mem.Tracking_Allocator
		mem.tracking_allocator_init(&tracker, context.allocator)
		context.allocator = mem.tracking_allocator(&tracker)
		defer cleanup_tracking_allocator(&tracker)
	}

	raylib_init()
	defer raylib_cleanup()

	assets := load_assets()
	defer unload_assets(&assets)

	background := background_new(&assets.background)


	for (!rl.WindowShouldClose()) {
		rl.BeginDrawing()

		rl.ClearBackground(rl.WHITE)

		background_draw(&background)

		rl.EndDrawing()
	}
}
