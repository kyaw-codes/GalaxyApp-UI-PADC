//
//  TabBar.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 07/05/2021.
//

import UIKit
import SnapKit

class TabBar: UIView {
    
    // MARK: - Properties
    
    var coordinator: MainCoordinator?

    private var horizontalBarLeftConstraint: Constraint?

    // MARK: - Views
    
    private let header = TabHeader()

    private let horizontalBarView = UIView(backgroundColor: .galaxyViolet)

    private let contentView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.alwaysBounceHorizontal = true
        cv.register(TabContentCell.self, forCellWithReuseIdentifier: "tabContent")
        cv.isPagingEnabled = true
        cv.keyboardDismissMode = .interactive
        return cv
    }()
    
    private let loginVC = AuthenticationFormVC(viewType: .signIn)
    private let signupVC = AuthenticationFormVC(viewType: .signUp)

    // MARK: - Initializers & Lifecycle Methods
    
    init(coordinator: MainCoordinator?) {
        super.init(frame: .zero)
        
        self.coordinator = coordinator
        
        setHeaderView()
        setupHorizontalBar()
        setupContentView()
        
        loginVC.onConfirmTapped = { coordinator in
            coordinator.home()
        }

        signupVC.onConfirmTapped = { coordinator in
            coordinator.home()
        }
    }
    
    override func layoutSubviews() {
        horizontalBarView.snp.makeConstraints { (make) in
            make.width.equalTo((frame.width - 40) / 2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Layout Views
    
    fileprivate func setHeaderView() {
        header.delegate = self
        addSubview(header)
        header.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    fileprivate func setupContentView() {
        contentView.delegate = self
        contentView.dataSource = self
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(header.snp.bottom)
        }
    }
    
    fileprivate func setupHorizontalBar() {
        addSubview(horizontalBarView)
        horizontalBarView.snp.makeConstraints { (make) in
            horizontalBarLeftConstraint = make.leading.equalToSuperview().inset(20).constraint
            make.bottom.equalTo(header.snp.bottom)
            make.height.equalTo(4)
        }
    }
    
    // MARK: - Private Helpers
    
    private func switchTabHeaderSelection(basedOn currentOffsetX: CGFloat) {
        if currentOffsetX <= (frame.width / 2) {
            header.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
        } else {
            header.selectItem(at: IndexPath(row: 1, section: 0), animated: true, scrollPosition: .left)
        }
    }
    
    private func dismissKeyboard(basedOn offsetX: CGFloat) {
        if offsetX == 0 {
            signupVC.view.endEditing(true)
        } else {
            loginVC.view.endEditing(true)
        }
    }
}

// MARK: - CollectionView DataSource & Delegate

extension TabBar: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabContent", for: indexPath) as? TabContentCell else { fatalError() }
        [loginVC, signupVC].forEach { $0.coordinator = coordinator }
        cell.viewController = indexPath.item == 0 ? loginVC : signupVC
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == header {
            return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height)
        } else {
            // Content View
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height - 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == contentView {
            return UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        } else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == header {
            contentView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentContentOffset = scrollView.contentOffset
        let maxHorizontalBarMargin = (frame.width / 2) - 20
        let maxContentOffset = frame.width
        
        let insetForHorizontalBar: CGFloat = currentContentOffset.x * (maxHorizontalBarMargin / CGFloat(maxContentOffset)) + 20
        
        horizontalBarLeftConstraint?.update(inset: insetForHorizontalBar)
        
        switchTabHeaderSelection(basedOn: currentContentOffset.x)
        dismissKeyboard(basedOn: currentContentOffset.x)
    }
}
