//
//  ModulledCollectionView.swift
//  UltimateGuitar
//
//  Created by admin on 3/21/17.
//
//

import UIKit

class ModulledCollectionViewController: UICollectionViewController {
    
    var modules: [CollectionModule]! { didSet {
        modules.forEach { $0.prepare(for: self.collectionView!) }
    }}
    
    func createModules() -> [CollectionModule] {
        fatalError("modules must be initialized in func createModules in concrete subclass")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modules = createModules()
    }
    
    //MARK: Delegate
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return modules[indexPath.section].collectionView(collectionView, shouldHighlightItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        modules[indexPath.section].collectionView(collectionView, didHighlightItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        modules[indexPath.section].collectionView(collectionView, didHighlightItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return modules[indexPath.section].collectionView(collectionView, shouldSelectItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return modules[indexPath.section].collectionView(collectionView, shouldDeselectItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        modules[indexPath.section].collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        modules[indexPath.section].collectionView(collectionView, didDeselectItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        modules[indexPath.section].collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        modules[indexPath.section].collectionView(collectionView, willDisplaySupplementaryView: view, forElementKind: elementKind, at: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        modules[indexPath.section].collectionView(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        modules[indexPath.section].collectionView(collectionView, didEndDisplayingSupplementaryView: view, forElementOfKind: elementKind, at: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return modules[indexPath.section].collectionView(collectionView, shouldDeselectItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return modules[indexPath.section].collectionView(collectionView, canPerformAction: action, forItemAt: indexPath, withSender: sender)
    }
    
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        modules[indexPath.section].collectionView(collectionView, performAction: action, forItemAt: indexPath, withSender: sender)
    }
    
    //MARK: DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modules[section].itemsCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return modules[indexPath.section].collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return modules[indexPath.section].collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return modules[indexPath.section].collectionView(collectionView, canMoveItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        modules[sourceIndexPath.section].collectionView(collectionView, moveItemAt: sourceIndexPath, to: destinationIndexPath)
    }
}
