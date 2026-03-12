import Cocoa
import SpriteKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Properties
    private var window: NSWindow!
    private var windowController: LandscapeWindowController!

    // MARK: - App Lifecycle

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create a small, minimal window — the Touch Bar requires
        // the app to be active (frontmost) to display its content
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 360, height: 80),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        window.title = "🏔️ Touch Bar Landscape"
        window.isReleasedWhenClosed = false
        window.center()

        // Add a simple label to the window content
        let label = NSTextField(labelWithString: "✨ Pixel art is scrolling on your Touch Bar!\nKeep this window focused to see it.")
        label.alignment = .center
        label.font = NSFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabelColor
        label.translatesAutoresizingMaskIntoConstraints = false

        let contentView = NSView(frame: window.contentView!.bounds)
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
        ])
        window.contentView = contentView

        // Use a custom WindowController that provides the Touch Bar
        windowController = LandscapeWindowController(window: window)
        windowController.showWindow(nil)

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
