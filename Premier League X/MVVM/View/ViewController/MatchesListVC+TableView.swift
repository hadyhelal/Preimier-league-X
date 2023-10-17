//
//  MatchesListVC+TableView.swift
//  Premier League X
//
//  Created by WAITEG on 17/10/2023.
//

import UIKit

extension MatchesListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch displayMatchType {
        case .matches:
            return matches.count
        case .favoriteMatches:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch displayMatchType {
        case .matches:
            return matches[section].matches.count
        case .favoriteMatches:
            return favoritematches.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyMatchesCell.id, for: indexPath) as! DailyMatchesCell
        cell.selectionStyle = .none
        
        setUp(matchCell: cell, at: indexPath)
        
        return  cell
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = MatchesHeaderView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        switch displayMatchType {
        case .matches:
            let date = matches[section].date
            view.headerTextLabel.text = DateFormatterManager.getLeagueDateStr(date)
        case .favoriteMatches:
            view.headerTextLabel.text = "Favorite Matches."

        }
        
        return view
    }
    
    private func setUp(matchCell cell: DailyMatchesCell, at indexPath: IndexPath) {
        switch displayMatchType {
        case .matches:
            cell.configure(match: matches[indexPath.section].matches[indexPath.row])
        case .favoriteMatches:
            cell.configure(match: favoritematches[indexPath.row])
        }
        
        cell.favoriteMatch = { [weak self] in
            guard let self else {return}
            self.matches[indexPath.section].matches[indexPath.row].isFavorite.toggle()
            
            let isFavorite = self.matches[indexPath.section].matches[indexPath.row].isFavorite
            cell.updateFavorite(favorite: isFavorite)
            
            let match = self.matches[indexPath.section].matches[indexPath.row]

            switch isFavorite {
            case true:
                self.favoritematches.append(match)
            case false:
                self.favoritematches.removeAll{$0 == match}
            }
            
        }
                
    }
    
}
