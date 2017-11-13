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
        
        get("uppercase", ":lowercase") { req in
            guard let lowercase = req.parameters["lowercase"]?.string else {
                return "Error retrieving parameters\n"
            }
            return lowercase.uppercased()
        }
        
        get("name", ":x") { req in
            guard let name = req.parameters["x"]?.string else {
                return "Error retrieving parameters\n"
            }
            return "Hello \(name)\n"
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
