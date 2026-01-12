package main

@(require) import mem "core:mem"
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

	assets := assets_load()
	defer assets_unload(&assets)

	background := background_init(&assets.background)
	clouds: [3]Cloud
	clouds_init(&assets.cloud, clouds[:])


	for (!rl.WindowShouldClose()) {
		dt := rl.GetFrameTime()

		// Handle Input

		// Handle Updates
		for &cloud in clouds {
			cloud_update(&cloud, dt)
		}

		// Handle Rendering
		rl.BeginDrawing()

		rl.ClearBackground(rl.WHITE)

		background_draw(&background)
		for &cloud in clouds {
			cloud_draw(&cloud)
		}

		rl.EndDrawing()
	}
}
