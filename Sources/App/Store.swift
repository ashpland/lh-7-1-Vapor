//
//  Store.swift
//  HelloPackageDescription
//
//  Created by Andrew on 2017-11-13.
//

class Store {
    static let sharedInstance = Store()
    
    var internalStore = [String:String]()
    
    init() {
       
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
    
    
    
    
    func add(value: String, key: String) {
        internalStore.updateValue(value, forKey: key)
    }
    
    func get(key: String) -> String? {
        return internalStore[key]
    }
    
    
}
