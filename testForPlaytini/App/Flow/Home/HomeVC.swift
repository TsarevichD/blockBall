//
//  HomeVC.swift

import Foundation
import UIKit

class HomeVC: UIViewController {
    
    
    private var contentView: HomeView {
        view as? HomeView ?? HomeView()
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            tappedButtons()
    }
 
    private func tappedButtons() {
            contentView.btnPlay.addTarget(self, action: #selector(goPlay), for: .touchUpInside)
    }
    
    
    @objc func goPlay() {
        let vc = GameVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
