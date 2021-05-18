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
        
        let vc: UIViewController!
        
        init(inside: UIViewController) {
            self.vc = inside
        }
        
        var position: FloatingPanelPosition = .bottom
        var initialState: FloatingPanelState = .half
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
                return [
                    .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
                    .half: FloatingPanelLayoutAnchor(fractionalInset: 0.6, edge: .bottom, referenceGuide: .safeArea)
                ]
            }
    }
}
