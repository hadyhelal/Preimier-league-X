//
//  DatabaseUtilities.swift
//  Premier League X
//
//  Created by WAITEG on 17/10/2023.
//

import Foundation
import CoreData

enum DataBaseEntities: String {
    case favoriteMatch = "FavoriteMatch"
}


protocol DatabaseOperations: AnyObject {
    associatedtype T: BaseEntity
        
    func setEntities( _ entities: [T])
    func getEntities() -> [T]
}

protocol DatabaseDeleteOperations: AnyObject {
    associatedtype T: BaseEntity
    
    func deleteEntity( _ entity: T)
}

protocol BaseEntity {}
