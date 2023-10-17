//
//  MatchesListVM.swift
//  Premier League X
//
//  Created by Hady on 16/10/2023.
//

import Foundation

protocol MatchesArrangedProtocol {
    func getArrangedMatchesFrom(_ matches: [Match]) -> [MatchesSection]
    func removeAnyPreviousMatches(arrangedMatches: [MatchesSection]) ->  [MatchesSection]
    func getArrangedMatches(_ matches: inout [Match] ) -> [MatchesSection]
}

class MatchesListVM {
    
    
    var successMessage: ( (String) -> Void )?
    var errorMessage: ( (String) -> Void )?
    var loadingView: ( (LoadingView) -> Void )?
    
    var networkError: ( (AuthError) -> Void)?
    var observeMatches: ( ([MatchesSection]) -> Void)?
    
    let matchesAPI: MatchesAPIProtocol
    let matchQueryManager: MatchesArrangedProtocol
    
    init(matchesAPI: MatchesAPIProtocol, matchQueryManager: MatchesArrangedProtocol) {
        self.matchesAPI = matchesAPI
        self.matchQueryManager = matchQueryManager
    }
    
    func getMatches() {
        loadingView?(.show)
        
        matchesAPI.getMatches { [weak self] result in
            guard let self else {return}
            
            self.loadingView?(.hide)
            
            switch result {
            case .success(let matchesModel):
                guard var matches = matchesModel?.matches, matches.isEmpty == false else {
                    self.errorMessage?("No matches to display")
                    return
                }
                
//                matches.sort{ $0.matchDate < $1.matchDate}
//
//                var arrangedMatches = self.getArrangedMatches(&matches)
//
//                arrangedMatches = self.removeAnyPreviousMatches(arrangedMatches: arrangedMatches)
//
                let arrangedMatches = self.matchQueryManager.getArrangedMatchesFrom(matches)
                self.observeMatches?(arrangedMatches)
                
            case .failure(let error):
                self.networkError?(error)
            }
            
            
        }
        
    }
    

    
    
    
    
    
}

class ArrangeMatchManager: MatchesArrangedProtocol {
    
    //we didn't make it private as we could want later to show favorite matches as well with dates...
    func getArrangedMatchesFrom(_ matches: [Match]) -> [MatchesSection] {
        var matchesVar = matches
        matchesVar.sort{ $0.matchDate < $1.matchDate}
        
        var arrangedMatches = self.getArrangedMatches(&matchesVar)
        
        arrangedMatches = self.removeAnyPreviousMatches(arrangedMatches: arrangedMatches)
        
        return arrangedMatches
    }
    
    func removeAnyPreviousMatches(arrangedMatches: [MatchesSection]) ->  [MatchesSection] {
        arrangedMatches.filter{ Date() < $0.date || Date().hasSame([.year, .month, .day], as: $0.date)}
    }
    
    func getArrangedMatches(_ matches: inout [Match] ) -> [MatchesSection] {
        var arrangedMatches = [MatchesSection]()
        
        var nowDay = MatchesSection(date: matches.first!.matchDate, matches: [matches.first!])

        
        for (idx,match) in matches.enumerated() {
            guard idx < matches.count - 1 else {return arrangedMatches}
            
            let nextMatch = matches[idx + 1]
            
            if match.matchDate.hasSame(.day, as: nextMatch.matchDate) {
                nowDay.matches.append(nextMatch)
                
            } else {
                
                arrangedMatches.append(nowDay)
                
                nowDay = MatchesSection(date: nextMatch.matchDate, matches: [nextMatch])
            }
        }
        
        return arrangedMatches
        
    }
    
    

}
