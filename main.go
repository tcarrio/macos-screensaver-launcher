package main

import "os/exec"

func main() {
	exec.Command("/System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine").Output()
}
