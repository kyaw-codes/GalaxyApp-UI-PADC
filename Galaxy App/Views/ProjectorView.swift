//
//  ProjectorView.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/05/2021.
//

import UIKit

class ProjectorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        let contentView = ContentView(frame: self.frame)
        contentView.layer.shadowColor = UIColor.galaxyGreen.cgColor
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.4
        contentView.backgroundColor = .clear
        
        addSubview(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    class ContentView: UIView {

        override func draw(_ rect: CGRect) {
            let path = UIBezierPath()
            
            let pathWidth = frame.width * 0.9
            let startX = frame.width - pathWidth
            let endX = pathWidth
            
            let startPoint = CGPoint(x: startX, y: frame.height)
            let endPoint = CGPoint(x: endX, y: frame.height)
            let controlPoint = CGPoint(x: frame.width / 2, y: -10)

            path.move(to: startPoint)
            path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
            path.lineCapStyle = .round
            
            UIColor.galaxyGreen.setStroke()
            path.lineWidth = 5
            path.stroke()
        }
    }

}
