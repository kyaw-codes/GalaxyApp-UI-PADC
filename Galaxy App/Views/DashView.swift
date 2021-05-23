//
//  DashView.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/05/2021.
//

import UIKit

class DashLine: UIView {
    
    var color: UIColor!
    
    init(color: UIColor = .galaxyBlack) {
        super.init(frame: .zero)
        
        self.color = color
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func draw(_ rect: CGRect) {

        let path = UIBezierPath()
        let dashPattern: [CGFloat] = [1, 18]
        path.setLineDash(dashPattern, count: dashPattern.count, phase: 0)
        path.lineWidth = 8
        path.lineCapStyle = .round
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        color.setStroke()
        path.stroke()
        
    }

}
