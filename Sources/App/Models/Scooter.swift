//
//  Scooter.swift
//  App
//
//  Created by Kyle Lee on 9/2/19.
//

import Vapor

final class Scooter {
    
    var id: String?
    var name: String
    var location: Location
    
    init(id: String? = UUID().uuidString, name: String, location: Location) {
        self.id = id
        self.name = name
        self.location = location
    }
}

extension Scooter: Content {}

