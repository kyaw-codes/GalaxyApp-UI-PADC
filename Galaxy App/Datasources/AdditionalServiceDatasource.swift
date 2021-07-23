//
//  AdditionalServiceDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 10/06/2021.
//

import UIKit

class AdditionalServiceDatasource: NSObject, UICollectionViewDataSource {
    
    var snackList = [Snack]()
    var paymentMethods = [PaymentMethod]()
    var icons = [UIImage(named: "atm_card")!, UIImage(named: "credit_card")!, UIImage(named: "wallet")!]

    enum Section: Int, CaseIterable {
        case snackSection
        case promoCodeSection
        case paymentMethodSection
    }
    
    var onSnackTap: ((Snack, Int) -> Void)?
    
//    var paymentMethodVMs: [PaymentMethodCell.ViewModel] = [
//        .init(image: #imageLiteral(resourceName: "atm_card"), title: "Credit card", subtitle: "Visa, master card, JCB"),
//        .init(image: #imageLiteral(resourceName: "credit_card"), title: "Internet banking(ATM card)", subtitle: "Visa, master card, JCB"),
//        .init(image: #imageLiteral(resourceName: "wallet"), title: "E-wallet", subtitle: "Paypal")
//    ]
    
    private lazy var snackCellRegistration = UICollectionView.CellRegistration<SnackCell, Snack> { cell, indexPath, item in
        cell.snack = item
        cell.onSnackTap = self.onSnackTap
    }
    
    var promoCellRegistration = UICollectionView.CellRegistration<PromocodeCell, String> { _, _, _ in
    }
    
    private lazy var paymentMethodCellRegistration = UICollectionView.CellRegistration<PaymentMethodCell, PaymentMethod> { cell, indexPath, payment in
        cell.paymentMethod = payment
        cell.icon = self.icons[indexPath.item]
    }
    
    var paymentHeaderRegistration = UICollectionView.SupplementaryRegistration<MovieHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
        header.headerText = "Payment method"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Section.snackSection.rawValue {
            return snackList.count
        } else if section == Section.promoCodeSection.rawValue {
            return 1
        } else {
            return paymentMethods.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Section.snackSection.rawValue:
            return collectionView.dequeueConfiguredReusableCell(using: snackCellRegistration, for: indexPath, item: snackList[indexPath.item])
        case Section.promoCodeSection.rawValue:
            return collectionView.dequeueConfiguredReusableCell(using: promoCellRegistration, for: indexPath, item: "promocode")
        default:
            return collectionView.dequeueConfiguredReusableCell(using: paymentMethodCellRegistration, for: indexPath, item: paymentMethods[indexPath.item])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == Section.paymentMethodSection.rawValue {
            return collectionView.dequeueConfiguredReusableSupplementary(using: paymentHeaderRegistration, for: indexPath)
        } else {
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "defaultHeader", for: indexPath)
        }
    }
    
}
