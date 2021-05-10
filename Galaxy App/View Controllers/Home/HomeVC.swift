//
//  HomeVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 08/05/2021.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    var coordinator: HomeCoordinator?
    
    private lazy var menuBarWidth = view.frame.width * 0.8
        
    private let sideMenuVC = SideMenuVC()
    private lazy var sideMenuView = sideMenuVC.view!
    
    private let navView = UIView(backgroundColor: .systemBackground)
    
    private let containerView = UIView(backgroundColor: .systemBackground)
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (section, _) -> NSCollectionLayoutSection? in
            if section == 0 {
                return self?.createProfileSection()
            } else {
                return self?.createMovieSection()
            }
        }))
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private lazy var dataSource = HomeDatasource(for: collectionView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .galaxyViolet
        view.addSubview(containerView)
        containerView.frame = view.bounds
        
        setupNavBar()
        navigationController?.navigationBar.isHidden = true
        
        setupCollectionView()
        setupSideMenuBar()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
    }
    
    private func setupNavBar() {
        let menuButton = UIButton(iconImage: #imageLiteral(resourceName: "menu"))
        let searchButton = UIButton(iconImage: #imageLiteral(resourceName: "search"))
        menuButton.addTarget(self, action: #selector(handleMenuTapped), for: .touchUpInside)
        let sv = UIStackView(arrangedSubviews: [menuButton, UIView(), searchButton])
        navView.addSubview(sv)
        sv.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(40)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        containerView.addSubview(navView)
        navView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    private func setupSideMenuBar() {
        addChild(sideMenuVC)
        view.addSubview(sideMenuView)
        view.didAddSubview(sideMenuView)
        
        sideMenuView.frame = CGRect(x: -(menuBarWidth + sideMenuVC.shadowRadius), y: 0, width: menuBarWidth, height: view.frame.size.height)
    }
    
    private func setupCollectionView() {
        containerView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(navView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.delegate = self
        collectionView.dataSource = dataSource
    }

    private func createProfileSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        return section
    }
    
    private func createMovieSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.38), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .none, top: .none, trailing: .fixed(20), bottom: .none)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 30, trailing: 0)
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        ]
        return section
    }
    
    @objc private func handleMenuTapped() {
        if sideMenuView.transform == .identity {
            // Open the menu
            animateMenuOpen()
        } else {
            // Close the menu
            animateMenuClose()
        }
    }
    
    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        
        switch sender.state {
        case .ended:
            if translation.x >= 0 {
                animateMenuOpen()
            } else {
                animateMenuClose()
            }
        default:
            break
        }
    }
    
    private func animateMenuOpen() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else { return }
            self.sideMenuView.transform = CGAffineTransform(translationX: self.menuBarWidth + self.sideMenuVC.shadowRadius, y: 0)
            self.containerView.transform = CGAffineTransform(translationX: self.menuBarWidth, y: 0)
        }, completion: nil)
    }
    
    private func animateMenuClose() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else { return }
            self.sideMenuView.transform = .identity
            self.containerView.transform = .identity
        }, completion: nil)
    }
}

extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.movieDetail(dataSource.getMovie(at: indexPath))
    }
}
