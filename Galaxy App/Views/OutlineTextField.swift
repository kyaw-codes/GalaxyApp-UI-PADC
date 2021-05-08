//
//  OutlineTextField.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 07/05/2021.
//

import UIKit
import SnapKit

class OutlineTextField: UIView {
    
    var placeholder: String! {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var keyboardType: UIKeyboardType! {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    
    let textField = UITextField(textSize: 18, textFieldHeight: 40)
    
    init(placeholder: String = "", keyboardType: UIKeyboardType = .default) {
        super.init(frame: .zero)
        
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        
        self.snp.makeConstraints { (make) in
            make.height.equalTo(48)
        }
        
        addSubview(textField)
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        
        textField.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview().inset(-6)
        }
        
        let underlineView = UIView(backgroundColor: .galaxyLightBlack)
        addSubview(underlineView)
        underlineView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onViewTapped)))
    }
    
    @objc private func onViewTapped() {
        self.textField.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
