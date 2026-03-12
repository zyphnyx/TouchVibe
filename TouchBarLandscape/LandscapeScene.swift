import SpriteKit

/// An SKScene that displays an infinitely scrolling pixel art landscape.
/// Uses two identical sprite nodes placed side-by-side, continuously moving left.
/// When one node scrolls off-screen, it wraps around to the right side.
class LandscapeScene: SKScene {

    // MARK: - Configuration

    /// Scroll speed in points per second (adjust for desired pace)
    private let scrollSpeed: CGFloat = 50.0

    // MARK: - Nodes

    private var landscapeNode1: SKSpriteNode!
    private var landscapeNode2: SKSpriteNode!

    /// Track the last update time for delta-time calculations
    private var lastUpdateTime: TimeInterval = 0

    // MARK: - Scene Setup

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        backgroundColor = SKColor(red: 0.05, green: 0.05, blue: 0.15, alpha: 1.0)
        anchorPoint = CGPoint(x: 0, y: 0)

        setupLandscape()
    }

    private func setupLandscape() {
        // Load the landscape texture from the asset catalog
        let texture = SKTexture(imageNamed: "landscape")
        texture.filteringMode = .nearest  // Preserve pixel art crispness

        let nodeWidth = size.width
        let nodeHeight = size.height

        // Create two identical landscape sprites side by side
        landscapeNode1 = SKSpriteNode(texture: texture)
        landscapeNode1.anchorPoint = CGPoint(x: 0, y: 0)
        landscapeNode1.size = CGSize(width: nodeWidth, height: nodeHeight)
        landscapeNode1.position = CGPoint(x: 0, y: 0)
        landscapeNode1.zPosition = 0
        addChild(landscapeNode1)

        landscapeNode2 = SKSpriteNode(texture: texture)
        landscapeNode2.anchorPoint = CGPoint(x: 0, y: 0)
        landscapeNode2.size = CGSize(width: nodeWidth, height: nodeHeight)
        landscapeNode2.position = CGPoint(x: nodeWidth, y: 0)
        landscapeNode2.zPosition = 0
        addChild(landscapeNode2)
    }

    // MARK: - Update Loop

    override func update(_ currentTime: TimeInterval) {
        // Calculate delta time
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        }

        let deltaTime = currentTime - lastUpdateTime
        lastUpdateTime = currentTime

        // Prevent huge jumps (e.g., when app becomes active after sleeping)
        guard deltaTime < 1.0 else { return }

        // Move both nodes to the left
        let movement = scrollSpeed * CGFloat(deltaTime)
        landscapeNode1.position.x -= movement
        landscapeNode2.position.x -= movement

        // Wrap nodes: when one scrolls completely off the left edge,
        // reposition it to the right of the other node
        let nodeWidth = size.width

        if landscapeNode1.position.x <= -nodeWidth {
            landscapeNode1.position.x = landscapeNode2.position.x + nodeWidth
        }

        if landscapeNode2.position.x <= -nodeWidth {
            landscapeNode2.position.x = landscapeNode1.position.x + nodeWidth
        }
    }
}
