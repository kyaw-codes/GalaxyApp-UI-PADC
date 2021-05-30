//
//  Ticket.swift
//  Ticket
//
//  Created by Ko Kyaw on 30/05/2021.
//

import UIKit

class TicketView: UIView {
    
    private var topArcYOffset: CGFloat = 0
    private var bottomArcYOffset: CGFloat = 0
    private let arcSize: CGFloat = 26
    private let cornerRadius: CGFloat = 20
    
    private let topDashLineView = DashLine(color: .seatAvailable)
    private let bottomDashLineView = DashLine(color: .seatAvailable)
    private let infoSV = UIStackView(subViews: [], axis: .vertical)

    var ticket: Ticket? {
        didSet {
            guard let ticket = ticket else { return }
            imageView.image = ticket.cover
            
            movieNameLabel.text = "\(ticket.movieName)"
            movieFormatLabel.text = "\(ticket.duration) - \(ticket.format)"
            
            let detailInfos = [("Booking no", ticket.bookingNo),
             ("Show time - Date", ticket.showDateTime),
             ("Theater", ticket.theater),
             ("Screen", "\(ticket.screen)"),
             ("Row", ticket.row),
             ("Seat", ticket.seats),
             ("Price", "$\(ticket.price)")] as [(String, String)]
            
            detailInfos.forEach{
                let row = createTicketInfoSV(title: $0.0, value: $0.1)
                infoSV.addArrangedSubview(row)
            }
            
            barCodeImageView.image = ticket.movieName.appending(ticket.bookingNo).generateBarcode()
        }
    }
    
    private let imageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    private let movieNameLabel = UILabel(text: "", font: .poppinsRegular, size: 20, numberOfLines: 1, color: .galaxyBlack)
    private let movieFormatLabel = UILabel(text: "", font: .poppinsLight, size: 18, numberOfLines: 1, color: .seatReserved)
    private let barCodeImageView = UIImageView(image: nil, contentMode: .scaleAspectFit)

    init() {
        super.init(frame: .zero)
                
        backgroundColor = .clear
        layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        topArcYOffset = frame.height * 0.36
        bottomArcYOffset = frame.height * 0.88
        
        drawTicketLayer()
        drawDashes()
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(imageView)
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = cornerRadius
        imageView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        imageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(topArcYOffset * 0.7)
        }
        
        addSubview(movieNameLabel)
        movieNameLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(arcSize)
            make.top.equalTo(imageView.snp.bottom).inset(-4)
        }
        
        addSubview(movieFormatLabel)
        movieFormatLabel.snp.makeConstraints { (make) in
            make.top.equalTo(movieNameLabel.snp.bottom)
            make.leading.trailing.equalTo(movieNameLabel)
            make.bottom.equalTo(topDashLineView.snp.top).inset(-(arcSize / 2))
        }
        
        addSubview(infoSV)
        infoSV.distribution = .fillProportionally
        infoSV.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(movieFormatLabel)
            make.top.equalTo(topDashLineView.snp.bottom).inset(-arcSize)
            make.bottom.equalTo(bottomDashLineView.snp.bottom).inset(arcSize)
        }
        
        addSubview(barCodeImageView)
        barCodeImageView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(bottomDashLineView).inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func drawDashes() {
        addSubview(topDashLineView)
        topDashLineView.frame = CGRect(x: arcSize / 2, y: topArcYOffset, width: frame.width - arcSize, height: 1)

        addSubview(bottomDashLineView)
        bottomDashLineView.frame = CGRect(x: arcSize / 2, y: bottomArcYOffset, width: frame.width - arcSize, height: 1)
    }
    
    private func createTicketInfoSV(title: String, value: String) -> UIStackView {
        let titleLabel = UILabel(text: title, font: .poppinsRegular, size: 15, numberOfLines: 0, color: .seatReserved)
        let valueLabel = UILabel(text: value, font: .poppinsRegular, size: 15, numberOfLines: 1, color: .galaxyBlack, alignment: .right)
        return UIStackView(arrangedSubviews: [titleLabel, UIView(), valueLabel])
    }
    
    private func drawTicketLayer() {

        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

        let topLeftArcPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: topArcYOffset),
                                          radius: arcSize / 2,
                                          startAngle:  CGFloat(Double.pi / 2),
                                          endAngle: CGFloat(Double.pi + Double.pi / 2),
                                          clockwise: false)
        topLeftArcPath.close()

        let topRightArcPath = UIBezierPath(arcCenter: CGPoint(x:frame.width, y: topArcYOffset),
                                           radius: arcSize / 2,
                                           startAngle:  CGFloat(Double.pi / 2),
                                           endAngle: CGFloat(Double.pi + Double.pi / 2),
                                           clockwise: true)
        topRightArcPath.close()

        let bottomLeftArcPath = UIBezierPath(arcCenter: CGPoint(x:0, y: bottomArcYOffset),
                                             radius: arcSize / 2,
                                             startAngle:  CGFloat(Double.pi / 2),
                                             endAngle: CGFloat(Double.pi + Double.pi / 2),
                                             clockwise: false)
        bottomLeftArcPath.close()

        let bottomRightArcPath = UIBezierPath(arcCenter: CGPoint(x: frame.width, y: bottomArcYOffset),
                                              radius: arcSize / 2,
                                              startAngle:  CGFloat(Double.pi / 2),
                                              endAngle: CGFloat(Double.pi + Double.pi / 2),
                                              clockwise: true)
        bottomRightArcPath.close()

        [topLeftArcPath, topRightArcPath.reversing(), bottomLeftArcPath, bottomRightArcPath.reversing(), path].forEach { path.append($0) }

        let ticketShapeLayer = CAShapeLayer()
        ticketShapeLayer.frame = bounds
        ticketShapeLayer.path = path.cgPath
        ticketShapeLayer.fillColor = UIColor.white.cgColor

        layer.addSublayer(ticketShapeLayer)

        // Add elevation
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 14
    }
    

}
