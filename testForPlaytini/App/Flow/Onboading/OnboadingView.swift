//
//  OnboadingView.swift

import Foundation
import UIKit
import SnapKit

class OnboadingView: UIView {
    
    
    private (set) var imgBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgLoad
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private (set) var loadView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 5
        return view
    }()

    private(set) lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progress = 0.0
        progressView.progressTintColor = .yellow
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        return progressView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {

        [imgBackground, loadView] .forEach(addSubview(_:))
        loadView.addSubview(progressView)

    }
    
    private func setupConstraints() {
        imgBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(11)
            make.width.equalTo(250)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-150)
        }
        
        progressView.snp.makeConstraints { make in
            make.left.equalTo(loadView.snp.left)
            make.right.equalTo(loadView.snp.right)
            make.centerY.equalTo(loadView.snp.centerY)
            make.height.equalTo(loadView.snp.height)
        }
    }

}
