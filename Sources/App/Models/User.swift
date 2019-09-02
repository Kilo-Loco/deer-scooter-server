//
//  User.swift
//  App
//
//  Created by Kyle Lee on 9/2/19.
//

import Vapor

final class User: Content {
    let email: Email
    
    init(email: Email) {
        self.email = email
    }
}
