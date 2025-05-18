//
//  Vegetable.swift
//  GreenThumb
//
//  Created by Dainwi on 25/04/25.
//

import Foundation
import SwiftData

struct Vegetable: Decodable {
    var vegetableId: Int
    var vegetableCode: String
    var catalogId: Int
    var name: String
    var descriptionText: String
    var thumbnailImage: String
    var seedDepth: String
    var germinationSoilTemp: String
    var daysToGermination: Int
    var sowIndoors: String
    var sowOutdoors: String
    var phRange: String
    var growingSoilTemp: String
    var spacingBeds: String
    var watering: String
    var light: String
    var goodCompanions: String
    var badCompanions: String
    var sowingDescription: String
    var growingDescription: String
    var harvestDescription: String
    var active: Bool?
    var season: String
    var daysToHarvestSeeds: Int
    var daysToHarvestSeedlings: Int
    var healthBenefits: String

    enum CodingKeys: String, CodingKey {
        case vegetableId = "VegetableId"
        case vegetableCode = "VegetableCode"
        case catalogId = "CatalogId"
        case name = "Name"
        case descriptionText = "Description"
        case thumbnailImage = "ThumbnailImage"
        case seedDepth = "SeedDepth"
        case germinationSoilTemp = "GerminationSoilTemp"
        case daysToGermination = "DaysToGermination"
        case sowIndoors = "SowIndoors"
        case sowOutdoors = "SowOutdoors"
        case phRange = "PhRange"
        case growingSoilTemp = "GrowingSoilTemp"
        case spacingBeds = "SpacingBeds"
        case watering = "Watering"
        case light = "Light"
        case goodCompanions = "GoodCompanions"
        case badCompanions = "BadCompanions"
        case sowingDescription = "SowingDescription"
        case growingDescription = "GrowingDescription"
        case harvestDescription = "HarvestDescription"
        case active = "Active"
        case season = "Season"
        case daysToHarvestSeeds = "DaysToHarvestSeeds"
        case daysToHarvestSeedlings = "DaysToHarvestSeedlings"
        case healthBenefits = "HealthBenefits"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        vegetableId = try container.decode(Int.self, forKey: .vegetableId)
        vegetableCode = try container.decode(String.self, forKey: .vegetableCode)
        catalogId = try container.decode(Int.self, forKey: .catalogId)
        name = try container.decode(String.self, forKey: .name)
        descriptionText = try container.decode(String.self, forKey: .descriptionText)
        thumbnailImage = try container.decode(String.self, forKey: .thumbnailImage)
        seedDepth = try container.decode(String.self, forKey: .seedDepth)
        germinationSoilTemp = try container.decode(String.self, forKey: .germinationSoilTemp)
        daysToGermination = try container.decode(Int.self, forKey: .daysToGermination)
        sowIndoors = try container.decode(String.self, forKey: .sowIndoors)
        sowOutdoors = try container.decode(String.self, forKey: .sowOutdoors)
        phRange = try container.decode(String.self, forKey: .phRange)
        growingSoilTemp = try container.decode(String.self, forKey: .growingSoilTemp)
        spacingBeds = try container.decode(String.self, forKey: .spacingBeds)
        watering = try container.decode(String.self, forKey: .watering)
        light = try container.decode(String.self, forKey: .light)
        goodCompanions = try container.decode(String.self, forKey: .goodCompanions)
        badCompanions = try container.decode(String.self, forKey: .badCompanions)
        sowingDescription = try container.decode(String.self, forKey: .sowingDescription)
        growingDescription = try container.decode(String.self, forKey: .growingDescription)
        harvestDescription = try container.decode(String.self, forKey: .harvestDescription)
        active = try container.decodeIfPresent(Bool.self, forKey: .active)
        season = try container.decode(String.self, forKey: .season)
        daysToHarvestSeeds = try container.decode(Int.self, forKey: .daysToHarvestSeeds)
        daysToHarvestSeedlings = try container.decode(Int.self, forKey: .daysToHarvestSeedlings)
        healthBenefits = try container.decode(String.self, forKey: .healthBenefits)
    }
}
