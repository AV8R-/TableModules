//
//  ModulledTableView.swift
//  UltimateGuitar
//
//  Created by admin on 11/12/16.
//
//

import Foundation

class ModulledTableViewController: UITableViewController {
    var tableViewModules: [TableViewModule]! {
        didSet {
            tableViewModules.forEach { module in
                module.prepare(forTableView: self.tableView)
                module.parentController = self
                module.didChangeContentHandler = { [weak self] updatedModule in
                    if let index = self?.tableViewModules.index(where: { $0 === updatedModule }) {
                        self?.tableView.reloadSections(IndexSet(integer: index), with: .none)
                    } else {
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func createModules() {
        fatalError("modules must be initialized in func createModules in concrete subclass")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createModules()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewModules.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModules[section].numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moduleIndexPath = IndexPath(item: indexPath.item, section: 0)
        return tableViewModules[indexPath.section].tableView(tableView, cellForRowAtIndexPath: moduleIndexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewModules[section].heightForHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableViewModules[section].heightForFooter
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewModules[indexPath.section].tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableViewModules[section].tableView(tableView, viewForHeaderInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableViewModules[section].tableView(tableView, viewForFooterInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewModules[indexPath.section].tableView(tableView, didSelectRowAtIndexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableViewModules[indexPath.section].tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
    }
    
}
