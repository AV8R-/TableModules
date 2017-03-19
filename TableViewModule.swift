//
//  TableViewModule.swift
//  UltimateGuitar
//
//  Created by admin on 11/6/16.
//
//

import Foundation
import UGProViewModels
import UltimateGuitarKit

struct TableViewModuleConstants {
    var cell:   String
    var header: String?
    var footer: String?
}


typealias TableViewModule = TableViewModuleInterface & TableViewModuleImplementation

protocol TableViewModuleInterface: class {
    weak var parentController: UITableViewController? { set get }
    
    var constants: TableViewModuleConstants? { set get }
    var tableViewModel: UpdatableTableViewModel? { get }
    var didChangeContentHandler: ((TableViewModule)->Void)? { set get }
    var numberOfRows: Int { get }
    var heightForHeader: CGFloat { get }
    var heightForFooter: CGFloat { get }
    var heightForCellEstimated: CGFloat { get }
    
    /**
     * Подготавливает модуль для использования в table view
     **/
    func prepare(forTableView tableView: UITableView)
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath)
    func tableView(_ tableView: UITableView, canInteractRowAtIdnexPath indexPath: IndexPath) -> Bool
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat
    func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath)
}

protocol TableViewModuleImplementation: class {
    weak var parentController: UITableViewController? { set get }
    
    var constants: TableViewModuleConstants? { get }
    var tableViewModel: UpdatableTableViewModel? { get }
    var didChangeContentHandler: ((TableViewModule)->Void)? { set get }
}

extension TableViewModuleImplementation {
    func prepare(forTableView tableView: UITableView) {
        prepareTableView(tableView)
        tableViewModel?.didChangeContentHandler = { [weak self]  _ in
            if ((self as? TableViewModule) != nil) {
                self?.didChangeContentHandler?((self as? TableViewModule)!)
            }
            
        }
    }
    
    /**
     * Подготавливает table view для использования модуля
     **/
    func prepareTableView(_ tableView: UITableView) {
        tableViewModel?.prepare()
        guard let cell = constants?.cell else { return }
        let bundle = Bundle(for: type(of: self))
        let cellNib = UINib(nibName: cell, bundle: bundle)
        tableView.register(cellNib, forCellReuseIdentifier: cell)
        tableView.estimatedRowHeight = heightForCellEstimated
        
        
        if let header = constants?.header {
            let activityHeader  = UINib(nibName: header, bundle: bundle)
            tableView.register(activityHeader, forHeaderFooterViewReuseIdentifier: header)
        }
        
        if let footer = constants?.footer {
            let activityFooter  = UINib(nibName: footer, bundle: bundle)
            tableView.register(activityFooter, forHeaderFooterViewReuseIdentifier: footer)
        }

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = constants?.header {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: header)
            view?.contentView.backgroundColor = appearance()?.tableCellColor
            return view
        }
        else {
            let view = UITableViewHeaderFooterView()
            let bgView = UIView(frame: view.frame)
            bgView.backgroundColor = appearance()?.tableCellColor
            view.contentView.backgroundColor = appearance()?.tableCellColor
            bgView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(bgView)
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let footer = constants?.footer { return tableView.dequeueReusableHeaderFooterView(withIdentifier: footer) }
        else {
            let view = UITableViewHeaderFooterView()
            let bgView = UIView(frame: view.frame)
            bgView.backgroundColor = appearance()?.tableCellColor
            view.contentView.backgroundColor = appearance()?.tableCellColor
            bgView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(bgView)
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constants!.cell, for: indexPath)
        
        if let vmcell = cell as? ViewModelled {
            vmcell.viewModel = tableViewModel?.rowViewModel(atIndexPath: indexPath)
            vmcell.reloadData()
        }
        
        cell.isUserInteractionEnabled = (self as? TableViewModule)?.tableView(tableView, canInteractRowAtIdnexPath: indexPath) ?? true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {}
    
    var numberOfRows: Int {
        return tableViewModel?.numberOfRows(inSection: 0) ?? 0
    }
    
    func tableView(_ tableView: UITableView, canInteractRowAtIdnexPath indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        
    }
    
    var heightForHeader: CGFloat { return (parentController?.tableView?.style == .some(.grouped) ?  1 :  0) }
    var heightForFooter: CGFloat { return (parentController?.tableView?.style == .some(.grouped) ?  1 :  0) }
    var heightForCellEstimated: CGFloat { return 70 }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
