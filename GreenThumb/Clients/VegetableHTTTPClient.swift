//
//  VegetableHTTTPClient.swift
//  GreenThumb
//
//  Created by Dainwi on 25/04/25.
//

import Foundation

struct VegetableHTTTPClient {
    func fetchVegetables() async throws -> [Vegetable]{
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://azamsharp.com/vegetables.json")!);
        
        return try JSONDecoder().decode([Vegetable].self, from: data);
    }
}
