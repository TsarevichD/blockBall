//
//  OnboadingVC.swift

import Foundation
import UIKit

class OnboadingVC: UIViewController {
    
    private var contentView: OnboadingView {
        view as? OnboadingView ?? OnboadingView()
    }
    
    override func loadView() {
        view = OnboadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        contentView.layoutIfNeeded()
        animateProgressBar()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                  self.loadHomeVC()
              }
    }
    
    func animateProgressBar() {
        UIView.animate(withDuration: 3.5) {
            self.contentView.progressView.setProgress(1.0, animated: true)
        }
    }
    
    func loadHomeVC() {
                    let vc = HomeVC()
                    let navigationController = UINavigationController(rootViewController: vc)
                    navigationController.modalPresentationStyle = .fullScreen
                    present(navigationController, animated: true)
                    navigationController.setNavigationBarHidden(true, animated: false)
          
        }
}
