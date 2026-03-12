import Cocoa
import SpriteKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Properties
    private var window: NSWindow!

    // MARK: - App Lifecycle

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the Touch Bar view controller
        let touchBarVC = TouchBarViewController()

        // Create a small window — the Touch Bar requires the app to be
        // the active (frontmost) app with a key window
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 360, height: 80),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        window.title = "🏔️ Touch Bar Landscape"
        window.isReleasedWhenClosed = false
        window.contentViewController = touchBarVC
        window.center()

        // Activate the app so it becomes frontmost — required for Touch Bar
        NSApp.activate(ignoringOtherApps: true)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
