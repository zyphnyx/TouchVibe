import Cocoa
import SpriteKit

/// An NSViewController that provides the Touch Bar with an embedded SKView
/// displaying the scrolling pixel art landscape.
///
/// Using NSViewController (as the window's contentViewController) is the most
/// reliable way to inject a custom Touch Bar — it sits properly in the
/// responder chain between the view and the window.
class TouchBarViewController: NSViewController, NSTouchBarDelegate {

    // MARK: - Touch Bar Identifiers

    private static let touchBarIdentifier = NSTouchBar.CustomizationIdentifier("com.pixelart.touchbar.landscape")
    private static let landscapeItemIdentifier = NSTouchBarItem.Identifier("com.pixelart.touchbar.landscape.scene")

    // MARK: - Touch Bar Dimensions

    /// The Touch Bar is approximately 685pt wide and 30pt tall
    private let touchBarWidth: CGFloat = 685
    private let touchBarHeight: CGFloat = 30

    // MARK: - Properties

    private var skView: SKView?
    private var landscapeScene: LandscapeScene?

    // MARK: - View Lifecycle

    override func loadView() {
        // Create a simple content view with a label
        let contentView = NSView(frame: NSRect(x: 0, y: 0, width: 360, height: 80))

        let label = NSTextField(labelWithString: "✨ Pixel art is scrolling on your Touch Bar!\nKeep this app focused to see it.")
        label.alignment = .center
        label.font = NSFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabelColor
        label.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
        ])

        self.view = contentView
    }

    // MARK: - NSTouchBar Creation

    @available(macOS 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.customizationIdentifier = TouchBarViewController.touchBarIdentifier
        touchBar.delegate = self
        touchBar.defaultItemIdentifiers = [TouchBarViewController.landscapeItemIdentifier]
        return touchBar
    }

    // MARK: - NSTouchBarDelegate

    @available(macOS 10.12.2, *)
    func touchBar(
        _ touchBar: NSTouchBar,
        makeItemForIdentifier identifier: NSTouchBarItem.Identifier
    ) -> NSTouchBarItem? {

        guard identifier == TouchBarViewController.landscapeItemIdentifier else {
            return nil
        }

        let item = NSCustomTouchBarItem(identifier: identifier)

        // Create and configure the SKView for the Touch Bar
        let view = SKView(frame: NSRect(x: 0, y: 0, width: touchBarWidth, height: touchBarHeight))
        view.preferredFramesPerSecond = 60
        view.allowsTransparency = false
        view.showsFPS = false
        view.showsNodeCount = false
        view.ignoresSiblingOrder = true

        // Create the landscape scene
        let scene = LandscapeScene(size: CGSize(width: touchBarWidth, height: touchBarHeight))
        scene.scaleMode = .aspectFill

        // Present the scene in the SKView
        view.presentScene(scene)

        item.view = view

        // Store references to prevent deallocation
        self.skView = view
        self.landscapeScene = scene

        return item
    }
}
