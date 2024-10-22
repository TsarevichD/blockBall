//
//  GameScene.swift

import SnapKit
import SpriteKit
import GameplayKit
import UIKit

enum GameState {
    case back
    case updateScoreBackEnd
    case restart
    case gameBack
}

class GameScene: SKScene {
    private var popupActive: Bool = false
    public var resultTransfer: ((GameState) -> Void)?
    private var centeredSprite: SKSpriteNode?
    private var blockSpriteOne: SKSpriteNode!
    private var blockSpriteTwo: SKSpriteNode!
    let livesLabel = SKLabelNode()
    private var collisionCount = 0
    private let vibrationFeedback = UIImpactFeedbackGenerator(style: .medium)
    private var lives = 5
    private var canIncreaseCollisionCount = true


    
    override func didMove(to view: SKView) {
        addSettingsScene()
        setupGameSubviews()
        animationBlock()
    }

    private func addSettingsScene() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
    }
 
    
    private func setupGameSubviews() {
        setupBackground()
        setupNavigation()
        addBall()
    }
    
    private func setupBackground() {
        let hpNode = SKSpriteNode(imageNamed: "bgGame")
        hpNode.anchorPoint = .init(x: 0, y: 0)
        hpNode.size = .init(width: size.width, height: size.height)
        hpNode.position = CGPoint(x: 0, y: 0)
        hpNode.zPosition = -1
        addChild(hpNode)
    }
    
    
    private func setupNavigation() {
        let backBtn = CustomSKButton(texture: SKTexture(imageNamed: "btnBack"))
        backBtn.size = .init(width: 80, height: 80)
        backBtn.anchorPoint = .init(x: 0, y: 1.0)
        backBtn.position = CGPoint(x: 24.autoSize, y: size.height - 58.autoSize)
        backBtn.normal = UIImage(named: "btnBack")
        backBtn.zPosition = 50
        backBtn.action = { self.backHomeAction() }
        addChild(backBtn)
        
         livesLabel.text = "Lives: \(lives)"
         livesLabel.fontColor = .white
         livesLabel.fontSize = 40
         livesLabel.fontName = "Inter-Bold"
         livesLabel.horizontalAlignmentMode = .right
         livesLabel.verticalAlignmentMode = .top
         livesLabel.position = CGPoint(x: size.width - 24.autoSize, y: size.height - 78.autoSize) // Правый верхний угол
         livesLabel.zPosition = 50
         addChild(livesLabel)
        
        let emptyTexture = SKTexture()
        let plusButton = CustomSKButton(texture: emptyTexture)
            plusButton.size = CGSize(width: 60, height: 60)
            plusButton.color = .green
            plusButton.colorBlendFactor = 1.0
            plusButton.zPosition = 50
            let plusLabel = SKLabelNode(text: "+")
            plusLabel.fontColor = .black
            plusLabel.fontSize = 40
            plusLabel.verticalAlignmentMode = .center
            plusButton.addChild(plusLabel)
            plusButton.action = { self.increaseSize() }

            let minusButton = CustomSKButton(texture: emptyTexture)
            minusButton.size = CGSize(width: 60, height: 60)
            minusButton.color = .green
            minusButton.colorBlendFactor = 1.0
            minusButton.zPosition = 50
            let minusLabel = SKLabelNode(text: "-")
            minusLabel.fontColor = .black
            minusLabel.fontSize = 40
            minusLabel.verticalAlignmentMode = .center
            minusButton.addChild(minusLabel)
            minusButton.action = { self.decreaseSize() }

            let yPos = 60 + plusButton.size.height / 2
            plusButton.position = CGPoint(x: size.width / 2 - 70, y: yPos)
            minusButton.position = CGPoint(x: size.width / 2 + 70, y: yPos)
            
            addChild(plusButton)
            addChild(minusButton)
    }
   
    private func addBall() {
        centeredSprite = SKSpriteNode(texture: SKTexture(imageNamed: "imgBall"))
        centeredSprite?.size = CGSize(width: 120, height: 120)
        centeredSprite?.position = CGPoint(x: size.width / 2, y: size.height / 2)
        centeredSprite?.zPosition = 10
        centeredSprite?.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        centeredSprite?.physicsBody?.isDynamic = true
        centeredSprite?.physicsBody?.categoryBitMask = 1
        centeredSprite?.physicsBody?.contactTestBitMask = 2
        centeredSprite?.physicsBody?.collisionBitMask = 0

        if let centeredSprite = centeredSprite {
            addChild(centeredSprite)
            startRotationAnimation()
        }
    }

    private func startRotationAnimation() {
        let rotateAction = SKAction.rotate(byAngle: -.pi * 2, duration: 2.0)
        let repeatRotation = SKAction.repeatForever(rotateAction)
        centeredSprite?.run(repeatRotation)
    }

    private func decreaseSize() {
           centeredSprite?.size = CGSize(width: 60, height: 60)
        centeredSprite?.physicsBody = SKPhysicsBody(circleOfRadius: 30)
       }
    
    private func increaseSize() {
           centeredSprite?.size = CGSize(width: 120, height: 120)
        centeredSprite?.physicsBody = SKPhysicsBody(circleOfRadius: 60)
       }

    private func addBlockOne() {
        let blockSpriteOne = SKSpriteNode(texture: SKTexture(imageNamed: "imgBlock"))
        blockSpriteOne.size = CGSize(width: 200, height: 20)
        blockSpriteOne.position = CGPoint(x: -blockSpriteOne.size.width / 2, y: ((size.height / 2) - 50)) // Левый край экрана
        blockSpriteOne.zPosition = 10
        blockSpriteOne.physicsBody = SKPhysicsBody(rectangleOf: blockSpriteOne.size) // Добавляем физику
        blockSpriteOne.physicsBody?.isDynamic = true
        blockSpriteOne.physicsBody?.categoryBitMask = 2
        blockSpriteOne.physicsBody?.contactTestBitMask = 1
        blockSpriteOne.physicsBody?.collisionBitMask = 0
        addChild(blockSpriteOne)
        
        let moveAction = SKAction.moveTo(x: size.width + blockSpriteOne.size.width / 2, duration: 5.0) // Движение вправо
        let removeAction = SKAction.removeFromParent()
        blockSpriteOne.run(SKAction.sequence([moveAction, removeAction]))
    }

    private func addBlockTwo() {
        let blockSpriteTwo = SKSpriteNode(texture: SKTexture(imageNamed: "imgBlock"))
        blockSpriteTwo.size = CGSize(width: 200, height: 20)
        blockSpriteTwo.position = CGPoint(x: size.width + blockSpriteTwo.size.width / 2, y: ((size.height / 2) + 50)) // Правый край экрана
        blockSpriteTwo.zPosition = 10
        blockSpriteTwo.physicsBody = SKPhysicsBody(rectangleOf: blockSpriteTwo.size) // Добавляем физику
        blockSpriteTwo.physicsBody?.isDynamic = true
        blockSpriteTwo.physicsBody?.categoryBitMask = 2
        blockSpriteTwo.physicsBody?.contactTestBitMask = 1
        blockSpriteTwo.physicsBody?.collisionBitMask = 0
        addChild(blockSpriteTwo)
        
        let moveAction = SKAction.moveTo(x: -blockSpriteTwo.size.width / 2, duration: 5.0) // Движение влево
        let removeAction = SKAction.removeFromParent()
        blockSpriteTwo.run(SKAction.sequence([moveAction, removeAction]))
    }
    
    private func animationBlock() {
        let waitAction = SKAction.wait(forDuration: 6.0)
        let spawnBlocksAction = SKAction.run { [weak self] in
            self?.spawnBlocks()
        }
        let repeatAction = SKAction.repeatForever(SKAction.sequence([spawnBlocksAction, waitAction]))
        run(repeatAction)
    }
    
    private func spawnBlocks() {
        addBlockOne()
        addBlockTwo()
    }
}

extension GameScene {
    
   
    @objc private func settingsButtonAction() {
        guard popupActive == false else { return }
        resultTransfer?(.updateScoreBackEnd)
    }
    
    @objc private func backHomeAction() {
        guard popupActive == false else { return }
        resultTransfer?(.gameBack)
    }
    
    @objc private func backButtonAction() {
        guard popupActive == false else { return }
        resultTransfer?(.restart)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.node == centeredSprite || contact.bodyB.node == centeredSprite) {
            handleCollision(with: contact)
        }
    }
    
    private func handleCollision(with contact: SKPhysicsContact) {
        vibrationFeedback.impactOccurred() // Вибрация при столкновении
        
        // Удаляем блоки при столкновении
        if let block = contact.bodyA.node as? SKSpriteNode, block != centeredSprite {
            block.removeFromParent()
        }
        if let block = contact.bodyB.node as? SKSpriteNode, block != centeredSprite {
            block.removeFromParent()
        }

        // Проверяем, можно ли увеличивать счетчик
        if canIncreaseCollisionCount {
            // Увеличиваем счетчик столкновений и уменьшаем количество жизней
            collisionCount += 1
            lives -= 1

            // Обновляем текст с количеством жизней
            livesLabel.text = "Lives: \(lives)"
            
            // Блокируем возможность увеличения счетчика на 0.5 секунды
            canIncreaseCollisionCount = false
            
            // Через 0.5 секунды снимаем блокировку
            let waitAction = SKAction.wait(forDuration: 0.5)
            let enableAction = SKAction.run { [weak self] in
                self?.canIncreaseCollisionCount = true
            }
            run(SKAction.sequence([waitAction, enableAction]))
        }

        // Проверяем, не превысило ли количество столкновений 10
        if collisionCount >= 5 {
            centeredSprite?.removeAllActions() // Останавливаем вращение
            removeAllActions() // Останавливаем появление блоков
            resultTransfer?(.restart)
        }
    }

}
