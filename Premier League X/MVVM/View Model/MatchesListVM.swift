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
                guard let matches = matchesModel?.matches, matches.isEmpty == false else {
                    self.errorMessage?("No matches to display")
                    return
                }

                let arrangedMatches = self.matchQueryManager.getArrangedMatchesFrom(matches)
                self.observeMatches?(arrangedMatches)
                
            case .failure(let error):
                self.networkError?(error)
            }
            
            
        }
        
    }
    

    
    
    
    
    
}

