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
    
    //Setting up cell
    private func setUp(matchCell cell: DailyMatchesCell, at indexPath: IndexPath) {
        switch displayMatchType {
        case .matches:
            cell.configure(match: matches[indexPath.section].matches[indexPath.row])
        case .favoriteMatches:
            cell.configure(match: favoritematches[indexPath.row])
        }
        
        //when Favorite button get clicked
        cell.favoriteMatch = { [weak self] in
            guard let self else {return}
            
            var isFavorite = false
            
            switch self.displayMatchType {
            case .matches:
                
                //configure when user favorite/unfavorite match in base list
                isFavorite = self.configureFavoritingBaseMatchList(at: indexPath)

            case .favoriteMatches:
                
                //configure when user favorite/unfavorite match in favorite list
                isFavorite = self.configureFavoritingMatchList(at: indexPath)
                
            }
            
            cell.updateFavorite(favorite: isFavorite)
            
        }
                
    }
    
    //Retrive selected state to update cell
    private func configureFavoritingMatchList(at indexPath: IndexPath) -> Bool {
        favoritematches[indexPath.row].isFavorite.toggle()
        
        let isFavorite = favoritematches[indexPath.row].isFavorite
        
        
        let match = favoritematches[indexPath.row]

        switch isFavorite {
        case true:
            favoritematches.append(match)
        case false:
            favoritematches.removeAll{$0 == match}
            
            matchesTableView.deleteRows(at: [indexPath], with: .right)
            
            if let idx = self.matches[indexPath.section].matches.firstIndex(of: match) {
                self.matches[indexPath.section].matches[idx].isFavorite = false
            }
            
            self.matchesTableView.reloadData()
        }
        
        return isFavorite
    }
    
    
    //Retrive selected state to update cell
    private func configureFavoritingBaseMatchList(at indexPath: IndexPath) -> Bool {
        self.matches[indexPath.section].matches[indexPath.row].isFavorite.toggle()
        
        let isFavorite = self.matches[indexPath.section].matches[indexPath.row].isFavorite
        
        let match = self.matches[indexPath.section].matches[indexPath.row]
        
        switch isFavorite {
        case true:
            self.favoritematches.append(match)
        case false:
            self.favoritematches.removeAll{$0 == match}
        }
        
        return isFavorite
    }
    
    
}
