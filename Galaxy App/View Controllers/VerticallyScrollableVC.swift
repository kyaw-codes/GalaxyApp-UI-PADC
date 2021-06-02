//
//  VerticallyScrollableVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 02/06/2021.
//

import UIKit
import SnapKit

class VerticallyScrollableVC<T: Coordinator>: UIViewController {
    
    open var coordinator: T?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .systemBackground
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    let stackView: UIStackView = UIStackView(subViews: [], axis: .vertical, spacing: 20)
    
    private var bottomConstraint: Constraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.leading.trailing.top.centerX.equalToSuperview()
            bottomConstraint = make.bottom.equalToSuperview().constraint
        }
        
        layoutViews(inside: stackView)

        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        watchKeyboardNotification()
    }
    
    open func layoutViews(inside contentView: UIStackView) {
    }
    
    private func watchKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func handleKeyboardNotification(notification: NSNotification) {
        let isKeyboardShowing = notification.name == UIView.keyboardWillShowNotification
        let keyboardRect = ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]) as? NSValue)?.cgRectValue
        let bottomPadding: CGFloat = 20
        
        let keyboardHeight = (keyboardRect!.height - view.safeAreaInsets.bottom) + bottomPadding
        let bottomInset = isKeyboardShowing ? keyboardHeight : bottomPadding
        
        // Update the stack view bottom constraint
        bottomConstraint?.update(inset: bottomInset)
        
        let animationDuration = ((notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]) as? NSNumber)?.doubleValue
        
        UIView.animate(withDuration: animationDuration ?? 0) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }

}
