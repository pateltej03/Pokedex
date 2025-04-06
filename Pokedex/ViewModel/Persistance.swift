//
//  Persistance.swift
//  Pokedex
//
//  Created by Tej Patel on 04/11/24.
//


import Foundation

class Persistence<ModelData: Codable> {
    private let filename: String
    private var fileURL: URL {
        URL.documentsDirectory.appendingPathComponent("\(filename).json")
    }

    init(filename: String) {
        self.filename = filename
    }

    var modelData: ModelData? {
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                return try decoder.decode(ModelData.self, from: data)
            } catch {
                print("Error loading data from file: \(error)")
            }
        }
        return nil
    }

    func save(_ modelData: ModelData) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(modelData)
            try data.write(to: fileURL)
        } catch {
            print("Error saving data to file: \(error)")
        }
    }
}

extension URL {
    static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
