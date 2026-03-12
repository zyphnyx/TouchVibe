import Cocoa
import SpriteKit

/// A custom NSWindowController that provides the Touch Bar with an SKView
/// displaying the scrolling pixel art landscape.
class LandscapeWindowController: NSWindowController, NSTouchBarDelegate {

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

    // MARK: - NSTouchBar Creation

    @available(macOS 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.customizationIdentifier = LandscapeWindowController.touchBarIdentifier
        touchBar.delegate = self
        touchBar.defaultItemIdentifiers = [LandscapeWindowController.landscapeItemIdentifier]
        return touchBar
    }

    // MARK: - NSTouchBarDelegate

    @available(macOS 10.12.2, *)
    func touchBar(
        _ touchBar: NSTouchBar,
        makeItemForIdentifier identifier: NSTouchBarItem.Identifier
    ) -> NSTouchBarItem? {

        guard identifier == LandscapeWindowController.landscapeItemIdentifier else {
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
