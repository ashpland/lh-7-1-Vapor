import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }
        
        post("betterhello") { req in
           
            guard let name = req.data["name"]?.string else {
                throw Abort(.badRequest)
            }

            let decor = String.randomEmoji

            return "\(decor) \(name) \(decor)" 
        }

        
        
        get("plaintext") { req in
            return "Hello, swift!\n "
        }
        
        get("simpleuppercase", ":lowercase") { req in
            guard let lowercase = req.parameters["lowercase"]?.string else {
                return "Error retrieving parameters\n"
            }
            return lowercase.uppercased()
        }
        
        get("uppercase") { req in
            guard let lowercase = req.data["lowercase"]?.string else {
                return "Error retrieving parameters\n"
            }
            return lowercase.uppercased() + "\n"
        }
        
        get("greet") { req in
            guard let value = req.data["name"]?.string else {
                return "Error retrieving parameters\n"
            }
            return "Hello \(value)\n"
        }
        
        

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }
        
        try resource("posts", PostController.self)
    }
}

extension String{
    static var randomEmoji: String {
        let range = [UInt32](0x1F601...0x1F64F)
        let ascii = range[Int(drand48() * (Double(range.count)))]
        let emoji = UnicodeScalar(ascii)?.description
        return emoji!
    }
}
