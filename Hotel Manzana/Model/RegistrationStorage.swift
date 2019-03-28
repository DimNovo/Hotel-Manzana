//
//  RegistrationStorage.swift
//  Hotel Manzana
//
//  Created by Dmitry Novosyolov on 28/03/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import Foundation

class RegistrationStorage {
    
    static var shared = RegistrationStorage()
    
    let documentDirectory = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask).first!
    let archiveURL: URL
    
    private init()
    {
        archiveURL = documentDirectory.appendingPathComponent("registrations").appendingPathExtension("plist")
        print(#function, archiveURL)
        
    }
    
    func loadFromStorage() -> [Registration]?
    {
        guard let data = try? Data(contentsOf: archiveURL) else { return nil }
        let decoder = PropertyListDecoder()
        let decodedRegistrations = try? decoder.decode([Registration].self, from: data)
        
        return decodedRegistrations
    }
    
    func saveToStorage(registrations: [Registration])
    {
        let encoder = PropertyListEncoder()
        let encodedRegistrations = try? encoder.encode(registrations)
        
        do {
            try encodedRegistrations?.write(to: archiveURL, options: .noFileProtection)
        } catch {
            print(#function, error.localizedDescription)
        }
    }
}
