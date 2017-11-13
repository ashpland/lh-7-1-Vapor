//
//  Store.swift
//  HelloPackageDescription
//
//  Created by Andrew on 2017-11-13.
//

class Store {
    private var internalStore = [String:String]()
    
    init() {
       
    }
    
    func add(_ inputDictionary:[String:Any]) {
        if let sanitizedDictionary = inputDictionary.filter(ifString) as? [String : String] {
            internalStore.merge(sanitizedDictionary, uniquingKeysWith:cngFunc2())
        }
    }
    
    
    let ifString: (Dictionary<String, Any>.Element) -> Bool = {
        element in
            return element.value as? String != nil
    }
    
//    func chooseNew<K: Hashable,E> (value1: Dictionary<K,E>.Value, value2: Dictionary<K,E>.Value) -> Dictionary<K,E>.Value {
//
//        let toReturn : Dictionary<K, E>.Value = value2
//
//        return toReturn
//    }

    
    //typealias MapResult<T> = (_ result: () throws -> T) -> Void

    
    func cngFunc<T> (_: T, new: T) -> T {
        return new
    }
    
    func cngFunc2<T> () -> (T, T) -> T {
        return { (_, new) in new }
    }
    
    
    typealias GenericClosure<T> = (T, T) -> T
    
    let chooseNewGeneric: GenericClosure<String> = {
        (_, new) in new
    }
    
    let cng2: GenericClosure<Int> = {
        (_, new) in new
    }
    
    let chooseNewString:(String, String) -> String = {
        (_, new) in new
    }
    
    
    //: (Dictionary<K,E>.Value, Dictionary<K,E>.Value) -> Dictionary<K,E>.Value
    
//    let chooseNew = {
//        <>(_, new: E) in new}
//    }

    
    
    func add(value: String, key: String) {
        internalStore.updateValue(value, forKey: key)
    }
    
    func get(key: String) -> String? {
        return internalStore[key]
    }
    
    
}
