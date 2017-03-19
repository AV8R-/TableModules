//
//  ModulledModule.swift
//  UltimateGuitar
//
//  Created by admin on 11/20/16.
//
//

import Foundation
import UltimateGuitarKit

typealias Modulled = ModulledInterface & ModulledImplementation

protocol ModulledInterface {
    var modules: [(range: CountableRange<Int>, module: TableViewModule)] { get }
    
}

protocol ModulledImplementation {
    var modules: [(range: CountableRange<Int>, module: TableViewModule)] { get }

}

extension ModulledImplementation where Self:TableViewModule {
    func prepare(forTableView tableView: UITableView) {
        modules.forEach {
            $1.prepareTableView(tableView)
//            $1.didChangeContentHandler = { [weak self] module in
//                self?.didChangeContentHandler?(self!)
//            }
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
        var cell: UITableViewCell?
        modules.forEach { if $0 ~= indexPath.row { cell = $1.tableView(tableView, cellForRowAtIndexPath: IndexPath(row: indexPath.row - $0.lowerBound, section: indexPath.section)) } }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        modules.forEach { if $0 ~= indexPath.row { $1.tableView(tableView, didSelectRowAtIndexPath: IndexPath(row: indexPath.row - $0.lowerBound, section: indexPath.section)) } }
    }
    
    var numberOfRows: Int {
        var rows = 0
        modules.forEach { rows += $1.numberOfRows }
        return rows
    }
    
    func tableView(_ tableView: UITableView, canInteractRowAtIdnexPath indexPath: IndexPath) -> Bool {
        var can = false
        modules.forEach { if $0 ~= indexPath.row { can = $1.tableView(tableView, canInteractRowAtIdnexPath: IndexPath(row: indexPath.row - $0.lowerBound, section: indexPath.section)) } }
        return can
    }
    
    var heightForHeader: CGFloat { return 1 }
    var heightForFooter: CGFloat { return 1 }
    var heightForCellEstimated: CGFloat { return 70 }
}
