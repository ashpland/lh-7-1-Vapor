import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
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
