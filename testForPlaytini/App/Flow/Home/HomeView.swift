//
//  HomeView.swift

import Foundation
import UIKit
import SnapKit

class HomeView: UIView {
    
    private (set) var imgBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()

    private (set) var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Тут может быть ваша Реклама =))"
        label.font = .customFont(font: .inter, style: .bold, size: 36)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private (set) var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "user_Name"
        label.font = .customFont(font: .inter, style: .bold, size: 36)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private (set) var btnPlay: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .green
        btn.setTitle("Play", for: .normal)
        btn.titleLabel?.font = .customFont(font: .inter, style: .bold, size: 24)
        btn.setTitleColor(.red, for: .normal)
        btn.setTitleColor(.black, for: .highlighted)
        btn.layer.cornerRadius = 12
        return btn
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
    
        [imgBackground, titleLabel, nameLabel, btnPlay] .forEach(addSubview(_:))

    }
    
    private func setupConstraints() {
     
        imgBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(36)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        btnPlay.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(60)
            make.left.right.equalToSuperview().inset(36)
        }
    }
}
