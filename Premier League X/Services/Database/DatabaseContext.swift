////
////  DatabaseContext.swift
////  Premier League X
////
////  Created by WAITEG on 17/10/2023.
////
//

import UIKit

class DatabaseContext {
    
   private let appDelegate = UIApplication.shared.delegate as! AppDelegate
   
   lazy var context = appDelegate.persistentContainer.viewContext
}
