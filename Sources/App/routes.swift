import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get { req in
        return "Welcome to deer!"
    }

    let userController = UserController()
    router.get("api", "users", use: userController.getUsers)
    router.post("api", "users", use: userController.createUser)
    
    let scooterController = ScooterController()
    router.get("api", "scooters", use: scooterController.allScooters)
    router.get("api", "scooters", String.parameter, use: scooterController.scooterById)
    router.post("api", "scooters", use: scooterController.createScooter)
    router.put("api", "scooters", use: scooterController.updateScooter)
    router.delete("api", "scooters", String.parameter, use: scooterController.deleteScooter)
}
