//
//  AdditionalServiceDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 10/06/2021.
//

import UIKit

class AdditionalServiceDatasource: NSObject, UICollectionViewDataSource {

    enum Section: Int, CaseIterable {
        case comboSection
        case promoCodeSection
        case paymentMethodSection
    }
    
    var comboCellVMs: [ComboSetCell.ViewModel] = [
        .init(title: "Combo set M", description: "Combo size M 22oz. Coke(X1) and medium popcorn (X1)", unitPrice: 15),
        .init(title: "Combo set L", description: "Combo size M 32oz. Coke(X1) and large popcorn (X1)", unitPrice: 18),
        .init(title: "Combo for 2", description: "Combo size M 2 32oz. Coke(X2) and large popcorn (X1)", unitPrice: 20)
    ]
    
    var paymentMethodVMs: [PaymentMethodCell.ViewModel] = [
        .init(image: #imageLiteral(resourceName: "atm_card"), title: "Credit card", subtitle: "Visa, master card, JCB"),
        .init(image: #imageLiteral(resourceName: "credit_card"), title: "Internet banking(ATM card)", subtitle: "Visa, master card, JCB"),
        .init(image: #imageLiteral(resourceName: "wallet"), title: "E-wallet", subtitle: "Paypal")
    ]
    
    var comboCellRegistration = UICollectionView.CellRegistration<ComboSetCell, ComboSetCell.ViewModel> { cell, indexPath, viewModel in
        cell.viewModel = viewModel
    }
    
    var promoCellRegistration = UICollectionView.CellRegistration<PromocodeCell, String> { _, _, _ in
    }
    
    var paymentMethodCellRegistration = UICollectionView.CellRegistration<PaymentMethodCell, PaymentMethodCell.ViewModel> { cell, indexPath, viewModel in
        cell.viewModel = viewModel
    }
    
    var paymentHeaderRegistration = UICollectionView.SupplementaryRegistration<MovieHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
        header.headerText = "Payment method"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Section.comboSection.rawValue {
            return comboCellVMs.count
        } else if section == Section.promoCodeSection.rawValue {
            return 1
        } else {
            return paymentMethodVMs.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Section.comboSection.rawValue:
            return collectionView.dequeueConfiguredReusableCell(using: comboCellRegistration, for: indexPath, item: comboCellVMs[indexPath.item])
        case Section.promoCodeSection.rawValue:
            return collectionView.dequeueConfiguredReusableCell(using: promoCellRegistration, for: indexPath, item: "promocode")
        default:
            return collectionView.dequeueConfiguredReusableCell(using: paymentMethodCellRegistration, for: indexPath, item: paymentMethodVMs[indexPath.item])
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
