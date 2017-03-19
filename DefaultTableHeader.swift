//
//  DefaultTableHeader.swift
//  UltimateGuitar
//
//  Created by admin on 11/15/16.
//
//

import Foundation

protocol TableViewModuleHeader: class {
    var contentViewTrick: UIView! { get }
}

class DefaultTableHeader: UITableViewHeaderFooterView, TableViewModuleHeader {
    @IBOutlet weak var contentViewTrick: UIView!
    @IBOutlet weak var title: UILabel!
}
