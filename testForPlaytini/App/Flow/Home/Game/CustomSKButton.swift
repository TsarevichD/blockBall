//
//  CustomSKButton.swift

import SpriteKit

class CustomSKButton: SKSpriteNode {
    var action: (() -> Void)?
    var active: Bool = true
    var disable: UIImage?
    var normal: UIImage? {
        didSet {
            guard let img = normal else { return }
            self.texture = SKTexture(image: img)
        }
    }
    var highlighted: UIImage?  

    init(texture: SKTexture) {
        super.init(texture: texture, color: .clear, size: texture.size())
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let highlightedImage = highlighted {
            texture = SKTexture(image: highlightedImage)
        } else {
        alpha = 0.5
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        alpha = 1.0
        texture = normal.map { SKTexture(image: $0) }

        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if contains(touchLocation) {
            action?()
        }
    }
    
    override func contains(_ point: CGPoint) -> Bool {
        let halfWidth = size.width
        let halfHeight = size.height
        
        return abs(point.x) < halfWidth && abs(point.y) < halfHeight
    }
    
    func setActive(active: Bool) {
        self.active = active
        isUserInteractionEnabled = active
        texture = active ? normal.map { SKTexture(image: $0) } : disable.map { SKTexture(image: $0) }
    }
}
