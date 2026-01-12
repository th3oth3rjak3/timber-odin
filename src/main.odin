package main

import rl "vendor:raylib"

main :: proc() {
	rl.SetTraceLogLevel(rl.TraceLogLevel.ALL)
	rl.InitWindow(1920, 1080, "Timber!!")
	defer rl.CloseWindow()

	rl.InitAudioDevice()
	defer rl.CloseAudioDevice()

	assets := load_assets()
	defer unload_assets(&assets)
	background := background_new(&assets.background)

	rl.SetTargetFPS(60)

	for (!rl.WindowShouldClose()) {
		rl.BeginDrawing()

		rl.ClearBackground(rl.WHITE)

		background_draw(&background)

		rl.EndDrawing()
	}
}
