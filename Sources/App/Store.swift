//
//  Store.swift
//  HelloPackageDescription
//
//  Created by Andrew on 2017-11-13.
//

import Foundation

class Store : NSObject, NSCoding {
    
    
    static let sharedInstance = Store()
    
    private var internalStore = [String:String]()
    
    override init() {
        
    }
    
    convenience init(withDictionary: [String:String]) {
        self.init()
        self.internalStore = withDictionary
    }
    
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(internalStore, forKey: "internalStore")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let internalStore = aDecoder.decodeObject(forKey: "internalStore") as? [String:String]
            else {return nil}
        self.init(withDictionary: internalStore)
    }
    
    
    func add(_ inputDictionary:[String:Any]) -> Int? {
        if let sanitizedDictionary = inputDictionary.filter(ifString) as? [String : String] {
            internalStore.merge(sanitizedDictionary, uniquingKeysWith:chooseNew())
            return sanitizedDictionary.count
        }
        return nil
    }
    
    
    let ifString: (Dictionary<String, Any>.Element) -> Bool = {
        element in
            return element.value as? String != nil
    }
    
    
    func chooseNew<T> () -> (T, T) -> T {
        return { (_, new) in new }
    }
    
    
    func get(key: String) -> String? {
        return internalStore[key]
    }
    
    
    
    
}
