package main

import "core:fmt"
import "core:mem"

// Call this function when using a tracking allocator to check for leaks/bad frees.
cleanup_tracking_allocator :: proc(tracker: ^mem.Tracking_Allocator) {
	fmt.eprintf("Tracking allocator results:\n")
	if len(tracker.allocation_map) > 0 {
		for _, leak in tracker.allocation_map {
			fmt.eprintf("%v leaked %m\n", leak.location, leak.size)
		}
	} else {
		fmt.eprintf("No leaks!\n")
	}

	fmt.eprintf("Tracking allocator bad frees:\n")
	if len(tracker.bad_free_array) > 0 {
		for b in tracker.bad_free_array {
			fmt.eprintf("Bad free at: %v\n", b.location)
		}
	} else {
		fmt.eprintf("No bad frees!\n")
	}

	mem.tracking_allocator_destroy(tracker)
}
