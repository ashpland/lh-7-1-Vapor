//
//  Store.swift
//  HelloPackageDescription
//
//  Created by Andrew on 2017-11-13.
//

import Foundation

class Store {
    
    static let sharedInstance = Store()
    
    private static var internalStore: [String:String] {
        get {
            if let data = UserDefaults.standard.object(forKey: "internalStore") as? Data {
                if let decodedInternalStore = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String:String] {
                    return decodedInternalStore
                }
            }
            return [String:String]()
        }
        
        set(updatedDictionary) {
            let data = NSKeyedArchiver.archivedData(withRootObject: updatedDictionary as Any)
            UserDefaults.standard.set(data, forKey: "internalStore")
        }
    }
    
    static func add(_ inputDictionary:[String:Any]) -> Int? {
        if let sanitizedDictionary = inputDictionary.filter(ifString) as? [String : String] {
            internalStore.merge(sanitizedDictionary, uniquingKeysWith:chooseNew())
            return sanitizedDictionary.count
        }
        return nil
    }
    
    private static let ifString: (Dictionary<String, Any>.Element) -> Bool = {
        element in
        return element.value as? String != nil
    }
    
    private static func chooseNew<T> () -> (T, T) -> T {
        return { (_, new) in new }
    }
    
    static func get(key: String) -> String? {
        return internalStore[key]
    }
    
    static func getAllItems() -> [String:String] {
        return internalStore
    }
}


