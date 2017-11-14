import Vapor
import Foundation

extension Droplet {
    func setupRoutes() throws {
        
        post("store") { req in
            var itemsStored: Int?
            do {
                if let jsonBytes = try req.json?.serialize() {
                    let jsonData : Data = Data(bytes: jsonBytes)
                    if let jsonObject = try JSONSerialization.jsonObject(with: jsonData) as? [String : Any] {
                        itemsStored = Store.add(jsonObject)
                    }
                }
            }
            catch { return "Something went wrong with the JSON"}
            
            let itemsStoredString: String = itemsStored?.description ?? "no"
            return "Stored \(itemsStoredString) items"
        }
        
        get("lookup", ":key") { req in
            guard let key = req.parameters["key"]?.string else {
                return "Error retrieving parameters\n"
            }
            return Store.get(key: key) ?? "No value"
        }
        
        get("retrieve") { req in
            let allItems = Store.getAllItems()
            if allItems.isEmpty { return "Nothing Stored" }
            else { return allItems.description }
        }
        
        
 
        try resource("posts", PostController.self)
    }
}
