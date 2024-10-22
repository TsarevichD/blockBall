//
//  GameVC.swift

import UIKit
import SpriteKit
import SnapKit

final class GameVC: UIViewController {
    private let gameSceneView = SKView()
    public var gameScene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupGameScene()
        receivingResultComplition()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setConstraints()
    }
}

// MARK: - Setup Subviews

extension GameVC {
    private func setupGameScene() {
        let size = CGSize(width: view.bounds.width, height: view.bounds.height)
        gameScene = GameScene(size: size)
        gameScene.scaleMode = .aspectFill
        
        gameSceneView.ignoresSiblingOrder = true
        gameSceneView.backgroundColor = .clear
        gameSceneView.presentScene(gameScene)
        view.addSubview(gameSceneView)
        gameScene.view?.showsFPS = false
        gameSceneView.showsPhysics = false
        
    }
    
    private func setConstraints() {
        gameSceneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Complition result game

extension GameVC {
    private func receivingResultComplition() {
        gameScene.resultTransfer = { [weak self] result in
            guard let self else { return }
            if result == .back {
                navigationController?.popViewController(animated: true)
            }
          
            if result == .restart {
                let alert = UIAlertController(title: "Game Over", message: "It didn't work out quite right but we can try again", preferredStyle: .alert)
                
                // Кнопка "Restart", которая перезапускает игру
                let restartAction = UIAlertAction(title: "Restart", style: .default) { [weak self] _ in
                    self?.restartGame() // Вызов метода перезапуска игры
                }
                
                alert.addAction(restartAction)
                present(alert, animated: true, completion: nil)
            }

            if result == .gameBack {
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    private func restartGame() {
        // Очищаем текущую сцену
        gameSceneView.presentScene(nil)

        // Создаем и запускаем новую сцену
        let size = CGSize(width: view.bounds.width, height: view.bounds.height)
        gameScene = GameScene(size: size)
        gameScene.scaleMode = .aspectFill
        gameSceneView.presentScene(gameScene)
        
        // Повторно привязываем результат
        receivingResultComplition()
    }

}

