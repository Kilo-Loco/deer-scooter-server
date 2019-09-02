//
//  ScooterController.swift
//  App
//
//  Created by Kyle Lee on 9/2/19.
//

import Vapor

final class ScooterController {
    
    private lazy var scooters: [String: Scooter] = {
        var scooters = [String: Scooter]()
        
        let prancer = Scooter(name: "Prancer", location: Location(latitude: 34.0289, longitude: -118.4735))
        scooters[prancer.id!] = prancer
        
        let dasher = Scooter(name: "Dasher", location: Location(latitude: 34.0303, longitude: -118.4730))
        scooters[dasher.id!] = dasher
        
        let cupid = Scooter(name: "Cupid", location: Location(latitude: 34.0306, longitude: -118.4713))
        scooters[cupid.id!] = cupid
        
        let dancer = Scooter(name: "Dancer", location: Location(latitude: 34.0308, longitude: -118.4743))
        scooters[dancer.id!] = dancer
        
        let vixen = Scooter(name: "Vixen", location: Location(latitude: 34.0301, longitude: -118.4753))
        scooters[vixen.id!] = vixen
        
        let comet = Scooter(name: "Comet", location: Location(latitude: 34.0289, longitude: -118.4735))
        scooters[comet.id!] = comet
        
        let donder = Scooter(name: "Donder", location: Location(latitude: 34.0280, longitude: -118.4735))
        scooters[donder.id!] = donder
        
        let blitzen = Scooter(name: "Blitzen", location: Location(latitude: 34.0300, longitude: -118.4695))
        scooters[blitzen.id!] = blitzen
        
        let rudolph = Scooter(name: "Rudolph", location: Location(latitude: 34.0333, longitude: -118.4740))
        scooters[rudolph.id!] = rudolph
        
        let bambi = Scooter(name: "Bambi", location: Location(latitude: 34.0301, longitude: -118.4732))
        scooters[bambi.id!] = bambi
        
        return scooters
    }()
    
    func allScooters(_ req: Request) throws -> [Scooter] {
        return Array(scooters.values)
    }
    
    func scooterById(_ req: Request) throws -> Scooter {
        let scooterId = try req.parameters.next(String.self)
        guard let scooter = scooters[scooterId] else { throw Abort(.badRequest) }
        return scooter
    }
    
    func createScooter(_ req: Request) throws -> Future<Scooter> {
        return try req.content.decode(Scooter.self).map { [weak self] (scooter) -> Scooter in
            let newScooter = Scooter(name: scooter.name, location: scooter.location)
            self?.scooters[newScooter.id!] = newScooter
            return newScooter
        }
    }
    
    func updateScooter(_ req: Request) throws -> Future<Scooter> {
        return try req.content.decode(Scooter.self).map { [weak self] (updatedScooter) -> Scooter in
            guard let scooterId = updatedScooter.id else { throw Abort(.badRequest) }
            self?.scooters[scooterId] = updatedScooter
            return updatedScooter
        }
    }
    
    func deleteScooter(_ req: Request) throws -> String {
        let scooterId = try req.parameters.next(String.self)
        guard let scooter = scooters[scooterId] else { throw Abort(.badRequest) }
        scooters[scooterId] = nil
        return "\(scooter.name) was deleted."
    }
}
