//
//  MatchesSection.swift
//  Premier League X
//
//  Created by WAITEG on 17/10/2023.
//

import Foundation

struct MatchesSection: Equatable {
    
    static func == (lhs: MatchesSection, rhs: MatchesSection) -> Bool {
        return lhs.date == rhs.date && lhs.matches == rhs.matches
    }
    
    let date: Date
    var matches: [Match]

    var numberOfItems: Int {
        return matches.count
    }

    subscript(index: Int) -> Match {
        return matches[index]
    }
}

extension MatchesSection {

    init(date: Date, matches: Match...) {
        self.date = date
        self.matches  = matches
    }
}
