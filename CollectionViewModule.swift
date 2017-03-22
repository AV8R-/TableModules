//
//  CollectionViewModule.swift
//  UltimateGuitar
//
//  Created by admin on 3/21/17.
//
//

import Foundation

enum ReusableView {
    case `class`(AnyClass)
    case nibName(String)
    
    class Bundler {}
    
    var `class`: AnyClass? {
        switch self {
        case let .class(cl): return cl
        default: return nil
        }
    }
    
    var nib: UINib? {
        switch self {
        case let .nibName(nib):
            let bundle = Bundle(for: Bundler.self)
            return UINib(nibName: nib, bundle: bundle)
        default:
            return nil
        }
    }
    
    var identifier: String {
        switch self {
        case let .class(c): return NSStringFromClass(c)
        case let .nibName(name): return name
        }
    }
}

typealias CollectionModule = CollectionModuleInterface & CollectionModuleImplementation

protocol CollectionModuleInterface: class {
    var itemsCount: Int { get }
    var reusableCell: ReusableView { set get }
    
    //MARK: Delegate
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?)
    
    //MARK: DataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
}

protocol CollectionModuleImplementation: class {
    var reusableCell: ReusableView { set get }
}

extension CollectionModuleImplementation where Self: CollectionModuleInterface {
    
    func prepare(for collection: UICollectionView) {
        if let nib = reusableCell.nib {
            collection.register(nib, forCellWithReuseIdentifier: reusableCell.identifier)
        } else if let clss = reusableCell.class {
            collection.register(clss, forCellWithReuseIdentifier: reusableCell.identifier)
        } else {
            fatalError("Module must register reusable cell with either class or nib")
        }
    }
}

extension CollectionModuleImplementation {
    //MARK: Delegate
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool { return true }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {}
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {}
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool { return true }
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool { return true }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {}
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {}
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {}
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {}
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {}
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool { return false }
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool { return true }
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {}
    
    //MARK: DataSource
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView { fatalError("Implement custom `viewForSupplementaryElementOfKind`") }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool { return false }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCell.identifier, for: indexPath)
        return cell
    }
}
