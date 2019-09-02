//
//  UserController.swift
//  App
//
//  Created by Kyle Lee on 9/2/19.
//

import Vapor

final class UserController {
    
    private var users = [User]()
    
    func getUsers(_ req: Request) throws -> [User] {
        return users
    }
    
    func createUser(_ req: Request) throws -> Future<User> {
        return try req.content.decode(User.self).do { [weak self] user in
            self?.users.append(user)
        }
    }
}
