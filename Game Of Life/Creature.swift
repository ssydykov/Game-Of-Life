import SpriteKit

class Creature: SKSpriteNode{
    
    // Character side
    var isAlive: Bool = false {
    
        didSet{
            // Visibility
            isHidden = !isAlive
        }
    }
    
    // Living neighbor counter
    var neighborCount = 0
    
    init() {
    
        // Initialize with bubble asset
        let texture = SKTexture (imageNamed: "bubble")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        // Setting z position on top of grid
        zPosition = 1
        
        // Set anchor point to bottom left
        anchorPoint = CGPoint(x: 0, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
}
