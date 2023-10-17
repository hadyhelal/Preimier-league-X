//
//  UITableView + Ext.swift
//  Premier League X
//
//  Created by Hady on 15/10/2023.

import UIKit

extension UITableView {
    func registerCell<Cell : UITableViewCell>(cell : Cell.Type){
        let nibName = String(describing: cell.self) // transform classCellName to String
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }

}

extension UICollectionView {
    func registerCell<Cell : UICollectionViewCell>(cell : Cell.Type){
        let nibName = String(describing: cell.self) // transform classCellName to String
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
}
