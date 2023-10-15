//
//  Data + Ext.swift
//  Car
//
//  Created by hady helal on 03/06/2022.
//

import Foundation

extension Data {
    func convertToJson() -> [String : Any]? {
        let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [String : Any]
        return json
    }
    
    func convertTo<T: Decodable>(to: T.Type) -> T?{
        
        var model: T?
        
        do {
            let decoder = JSONDecoder()
             model   = try decoder.decode(to.self, from: self)
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
            
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
        }  catch {
            print("error: ", error)
        }
        
        return model
    }
    
    
}

