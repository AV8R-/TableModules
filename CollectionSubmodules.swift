//
//  ModulledCollectionModule.swift
//  UltimateGuitar
//
//  Created by admin on 3/23/17.
//
//

import Foundation

protocol CollectionSubmodule: CollectionModule {
    
}

extension CollectionSubmodule {
    var itemsCount: Int {
        return 1
    }
}

class ModulledCollectionModule: CollectionModule {
    
    var submodules: [CollectionSubmodule] = []
    var itemsCount: Int {
        return submodules.count
    }
    var reusableCell: ReusableView = .class(UICollectionViewCell.self)
    var viewModel: TableViewModel!
    
    func prepare(for collection: UICollectionView) {
        submodules = createSubmodules()
        submodules.forEach { $0.prepare(for: collection) }
    }

    func createSubmodules() -> [CollectionSubmodule] {
        fatalError("func createSubmodules must be implemented in concrete subclass of ModulledCollectionModule")
    }
    
    //MARK: Delegate
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return submodules[indexPath.row].collectionView(collectionView, shouldHighlightItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        submodules[indexPath.row].collectionView(collectionView, didHighlightItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        submodules[indexPath.row].collectionView(collectionView, didUnhighlightItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return submodules[indexPath.row].collectionView(collectionView, shouldSelectItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return submodules[indexPath.row].collectionView(collectionView, shouldDeselectItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        submodules[indexPath.row].collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        submodules[indexPath.row].collectionView(collectionView, didDeselectItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        submodules[indexPath.row].collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        submodules[indexPath.row].collectionView(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return submodules[indexPath.row].collectionView(collectionView, shouldShowMenuForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return submodules[indexPath.row].collectionView(collectionView, canPerformAction: action, forItemAt: indexPath, withSender: sender)
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        submodules[indexPath.row].collectionView(collectionView, performAction: action, forItemAt: indexPath, withSender: sender)
    }
    
    //MARK: DataSource
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView { fatalError("Implement custom `viewForSupplementaryElementOfKind`") }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return submodules[indexPath.row].collectionView(collectionView, canMoveItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        fatalError("Implement custom `moveItemAt:to:`")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return submodules[indexPath.row].collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    //MARK: LayoutDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return submodules[indexPath.row].collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize()
    }

    
}
