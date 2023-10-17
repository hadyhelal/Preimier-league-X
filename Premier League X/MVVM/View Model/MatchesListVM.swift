//
//  MatchesListVM.swift
//  Premier League X
//
//  Created by Hady on 16/10/2023.
//

import Foundation

class MatchesListVM {
    
    
    var successMessage: ( (String) -> Void )?
    var errorMessage: ( (String) -> Void )?
    var loadingView: ( (LoadingView) -> Void )?
    
    var networkError: ( (AuthError) -> Void)?
    var observeMatches: ( ([ (Date,[Match]) ]) -> Void)?
    
    let matchesAPI: MatchesAPIProtocol
    
    init(matchesAPI: MatchesAPIProtocol) {
        self.matchesAPI = matchesAPI
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
                
                matches.sort{ $0.matchDate < $1.matchDate}
                
                var arrangedMatches = self.getArrangedMatches(&matches)
                
                arrangedMatches = self.removeAnyPreviousMatches(arrangedMatches: arrangedMatches)
                
                self.observeMatches?(arrangedMatches)
                
            case .failure(let error):
                self.networkError?(error)
            }
            
            
        }
        
    }
    
    fileprivate func removeAnyPreviousMatches(arrangedMatches: [ (Date,[Match]) ]) ->  [ (Date,[Match]) ] {
        arrangedMatches.filter{ Date() < $0.0 || Date().hasSame([.year, .month, .day], as: $0.0)}
    }
    
    fileprivate func getArrangedMatches(_ matches: inout [Match] ) -> [ (Date,[Match]) ] {
        var arrangedMatches = [ (Date,[Match]) ]()
        
        var nowDay: (Date,[Match]) = (matches.first!.matchDate, [matches.first!] )
        
        // arrangedMatches.append(nowDay) //First element
        
        //matches.removeFirst()
        
        for (idx,match) in matches.enumerated() {
            guard idx < matches.count - 1 else {return arrangedMatches}
            
            let nextMatch = matches[idx + 1]
            
            if match.matchDate.hasSame(.day, as: nextMatch.matchDate) {
                nowDay.1.append(nextMatch)
                
            } else {
                
                arrangedMatches.append(nowDay)
                
                nowDay = (nextMatch.matchDate, [nextMatch])
            }
        }
        
        return arrangedMatches
        
        
    }
    
    
    
}
