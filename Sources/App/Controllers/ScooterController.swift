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
        
        let prancer = Scooter(id: "B2BD832E-9AC7-46A5-A0CC-D4ED539F2224",
                              name: "Prancer",
                              location: Location(latitude: 34.0289, longitude: -118.4735))
        scooters[prancer.id!] = prancer
        
        let dasher = Scooter(id: "3150D744-C61C-4516-91AF-33B647B8B861",
                             name: "Dasher",
                             location: Location(latitude: 34.0303, longitude: -118.4730))
        scooters[dasher.id!] = dasher
        
        let cupid = Scooter(id: "F6A4499A-2BBF-4E1B-9BAE-1F8C6D6C1959",
                            name: "Cupid",
                            location: Location(latitude: 34.0306, longitude: -118.4713))
        scooters[cupid.id!] = cupid
        
        let dancer = Scooter(id: "D353F0CA-AEE8-4003-8DB1-E3BD66A54FD4",
                             name: "Dancer",
                             location: Location(latitude: 34.0308, longitude: -118.4743))
        scooters[dancer.id!] = dancer
        
        let vixen = Scooter(id: "CD143090-8BE0-4080-A4A6-81FAA1784152",
                            name: "Vixen",
                            location: Location(latitude: 34.0301, longitude: -118.4753))
        scooters[vixen.id!] = vixen
        
        let comet = Scooter(id: "879F2D6A-AD49-43AF-8C6B-2CE8412D98EE",
                            name: "Comet",
                            location: Location(latitude: 34.0289, longitude: -118.4735))
        scooters[comet.id!] = comet
        
        let donder = Scooter(id: "3200AF9F-5EB5-49C8-A1E6-DBD9F57EDDC8",
                             name: "Donder",
                             location: Location(latitude: 34.0280, longitude: -118.4735))
        scooters[donder.id!] = donder
        
        let blitzen = Scooter(id: "F1E780E0-FFDF-4AF6-83EC-32E5ED317B51",
                              name: "Blitzen",
                              location: Location(latitude: 34.0300, longitude: -118.4695))
        scooters[blitzen.id!] = blitzen
        
        let rudolph = Scooter(id: "61604FBF-66CD-4A35-8E5C-93E21B6E93E5",
                              name: "Rudolph",
                              location: Location(latitude: 34.0333, longitude: -118.4740))
        scooters[rudolph.id!] = rudolph
        
        let bambi = Scooter(id: "AED6C0A3-FA5D-43E2-BECB-54DB53085558",
                            name: "Bambi",
                            location: Location(latitude: 34.0301, longitude: -118.4732))
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
    
    func deleteScooter(_ req: Request) throws -> Scooter {
        let scooterId = try req.parameters.next(String.self)
        guard let scooter = scooters[scooterId] else { throw Abort(.badRequest) }
        scooters[scooterId] = nil
        return scooter
    }
}
