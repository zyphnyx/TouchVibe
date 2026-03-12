import Cocoa
import SpriteKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Properties
    private var window: NSWindow!
    private var windowController: LandscapeWindowController!

    // MARK: - App Lifecycle

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create a minimal hidden window — the Touch Bar needs an active window
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 300, height: 1),
            styleMask: [.titled, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        window.title = "Touch Bar Landscape"
        window.isReleasedWhenClosed = false
        window.level = .floating

        // Use a custom WindowController that provides the Touch Bar
        windowController = LandscapeWindowController(window: window)
        windowController.showWindow(nil)

        // Position off-screen so it's not visible
        window.setFrameOrigin(NSPoint(x: -10000, y: -10000))
        window.orderFront(nil)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
