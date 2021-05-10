//
//  ViewController.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 06/05/2021.
//

import UIKit
import SnapKit

class GetStartedVC: UIViewController {
    
    private let vectorImageView: UIImageView = UIImageView(image: UIImage(named: "horror_movie_vector"), contentMode: .scaleAspectFit)
    
    var coordinator: MainCoordinator?

    private let greetingLabel: UILabel = {
        let lbl = UILabel(text: "", font: .poppinsSemiBold, size: 28, numberOfLines: 0)
        let attrString = NSMutableAttributedString(string: "Welcome!\n")
        attrString.append(NSAttributedString(string: "Hello! Welcome to Galaxy App.", attributes: [NSAttributedString.Key.font : UIFont.GalaxyFont.poppinsLight.font(of: 18)]))
        lbl.attributedText = attrString
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private let startButton: UIButton = {
        let btn = OutlineButton(title: "Get Started")
        btn.outlineColor = .white
        btn.titleColor = .white
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .galaxyViolet
        navigationController?.navigationBar.isHidden = true
        
        setupView()
        startButton.addTarget(self, action: #selector(onStartTapped), for: .touchUpInside)
    }
    
    private func setupView() {
        let topContainerView = UIView()
        let bottomContainerView = UIView()
        
        view.addSubview(topContainerView)
        topContainerView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        topContainerView.addSubview(vectorImageView)
        vectorImageView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        view.addSubview(bottomContainerView)
        bottomContainerView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        bottomContainerView.addSubview(greetingLabel)
        greetingLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        bottomContainerView.addSubview(startButton)
        startButton.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            make.height.equalToSuperview().multipliedBy(0.16)
        }
    }
    
    @objc private func onStartTapped() {
        coordinator?.login()
    }

}

