//
//  MovieDetailVC+Layout.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 18/05/2021.
//

import UIKit
import FloatingPanel

extension MovieDetailVC {
    
    class Layout: FloatingPanelLayout {
        
        var position: FloatingPanelPosition = .bottom
        var initialState: FloatingPanelState = .half
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
                return [
                    .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
                    .half: FloatingPanelLayoutAnchor(fractionalInset: 0.64, edge: .bottom, referenceGuide: .safeArea)
                ]
            }
    }
    
    func setupView() {
        view.addSubview(movieImageView)
        
        movieImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(movieImageViewHeight)
        }

        view.addSubview(playButton)
        playButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        playButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(movieImageView)
            make.width.height.equalTo(66)
        }
        playButton.layer.cornerRadius = 66 / 2
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            make.leading.equalToSuperview().inset(20)
        }
        
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func setupFloatingMovieDescriptionVC() {
        let fpc = FloatingPanelController(delegate: self)
        fpc.surfaceView.backgroundColor = .clear
        fpc.backdropView.backgroundColor = .white

        fpc.layout = Layout()
        
        fpc.set(contentViewController: descriptionVC)
        fpc.contentMode = .static
        fpc.surfaceView.grabberHandleSize = .zero
        fpc.track(scrollView: descriptionVC.scrollView)

        fpc.addPanel(toParent: self)
        view.bringSubviewToFront(spinner)
    }
    
    func setupCTAButton() {
        let gradientView = UIView(backgroundColor: .clear)
        view.addSubview(gradientView)
        gradientView.isUserInteractionEnabled = false
        gradientView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(view.frame.height * 0.25)
        }
        gradientView.applyGradient(colours: [.init(white: 1, alpha: 0.15), .white], locations: [0.2, 0.7], frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.25))

        view.addSubview(getTicketButton)
        getTicketButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
}
