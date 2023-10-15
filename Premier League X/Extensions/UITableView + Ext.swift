//
//  UITableView + Ext.swift
//  Roshan
//
//  Created by WAITEG on 14/11/2022.
//

import UIKit

extension UITableView {
    func registerCell<Cell : UITableViewCell>(cell : Cell.Type){
        let nibName = String(describing: cell.self) // transform classCellName to String
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func isExist(indexPath: IndexPath) -> Bool {
        if indexPath.section >= self.numberOfSections {
            return false
        }
        if indexPath.row >= self.numberOfRows(inSection: indexPath.section) {
            return false
        }
        return true
    }
}

extension UICollectionView {
    func registerCell<Cell : UICollectionViewCell>(cell : Cell.Type){
        let nibName = String(describing: cell.self) // transform classCellName to String
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
}
