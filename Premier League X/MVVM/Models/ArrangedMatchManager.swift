//
//  ArrangedMatchManager.swift
//  Premier League X
//
//  Created by WAITEG on 17/10/2023.
//

import Foundation

class ArrangeMatchManager: MatchesArrangedProtocol {
    

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
