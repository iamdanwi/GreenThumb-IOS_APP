//
//  PreviewData.swift
//  GreenThumb
//
//  Created by Dainwi on 25/04/25.
//

import Foundation


struct PreviewData: Codable {
    static func loadVegetables() -> [Vegetable] {
        guard let url = Bundle.main.url(forResource: "vegetables", withExtension: "json") else {
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            let vegetables = try JSONDecoder().decode([Vegetable].self, from: data)
            return vegetables
        } catch {
            #if DEBUG
            print("Failed to load preview data: \(error)")
            #endif
            return []
        }
        
    }
}
