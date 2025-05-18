//
//  VegetableDetailScreen.swift
//  GreenThumb
//
//  Created by Dainwi on 25/04/25.
//

import SwiftUI

struct VegetableDetailScreen: View {
    let vegetable: Vegetable
    @State private var selectedSection = 0
    @State private var isImageExpanded = false
    
    // Custom color palette
    private let primaryGreen = Color(red: 0.2, green: 0.6, blue: 0.3)
    private let secondaryGreen = Color(red: 0.5, green: 0.8, blue: 0.5)
    private let accentOrange = Color(red: 0.95, green: 0.6, blue: 0.1)
    private let neutralGray = Color(red: 0.95, green: 0.95, blue: 0.97)
    private let darkText = Color(red: 0.2, green: 0.2, blue: 0.25)
    private let lightText = Color(red: 0.5, green: 0.55, blue: 0.6)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // MARK: - Header Image Section
                ZStack(alignment: .bottomLeading) {
                    // Hero Image with zoom capability
                    AsyncImage(url: URL(string: vegetable.thumbnailImage)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: isImageExpanded ? 400 : 280)
                            .clipped()
                            .animation(.spring(), value: isImageExpanded)
                            .onTapGesture {
                                withAnimation {
                                    isImageExpanded.toggle()
                                }
                            }
                    } placeholder: {
                        ZStack {
                            Rectangle()
                                .fill(neutralGray)
                                .frame(height: isImageExpanded ? 400 : 280)
                            
                            VStack(spacing: 8) {
                                Image(systemName: "leaf.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(primaryGreen.opacity(0.5))
                                
                                Text("Loading image...")
                                    .font(.caption)
                                    .foregroundColor(lightText)
                            }
                        }
                        .animation(.spring(), value: isImageExpanded)
                        .onTapGesture {
                            withAnimation {
                                isImageExpanded.toggle()
                            }
                        }
                    }
                    
                    // Gradient overlay
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                        startPoint: .center,
                        endPoint: .bottom
                    )
                    .frame(height: isImageExpanded ? 200 : 140)
                    
                    // Name and badges
                    VStack(alignment: .leading, spacing: 12) {
                        // Badges row
                        HStack {
                            Spacer()
                            
                            Group {
                                // ID badge
                                HStack(spacing: 4) {
                                    Image(systemName: "number")
                                        .font(.caption2)
                                    Text("ID: \(vegetable.vegetableId)")
                                        .font(.caption)
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(darkText.opacity(0.7))
                                .cornerRadius(20)
                                
                                // Season badge
                                HStack(spacing: 4) {
                                    Image(systemName: "calendar")
                                        .font(.caption2)
                                    Text(vegetable.season)
                                        .font(.caption)
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(accentOrange.opacity(0.9))
                                .cornerRadius(20)
                                
                                if let active = vegetable.active {
                                    // Status badge
                                    HStack(spacing: 4) {
                                        Image(systemName: active ? "checkmark.circle.fill" : "xmark.circle.fill")
                                            .font(.caption2)
                                        Text(active ? "Active" : "Inactive")
                                            .font(.caption)
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(active ? primaryGreen.opacity(0.9) : Color.red.opacity(0.9))
                                    .cornerRadius(20)
                                }
                            }
                            .foregroundColor(.white)
                        }
                        
                        // Name and code
                        VStack(alignment: .leading, spacing: 6) {
                            Text(vegetable.name)
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .shadow(radius: 2)
                            
                            HStack(spacing: 8) {
                                Text("Code: \(vegetable.vegetableCode)")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.9))
                                
                                Text("•")
                                    .foregroundColor(.white.opacity(0.5))
                                
                                Text("Catalog: \(vegetable.catalogId)")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.9))
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                
                // MARK: - Description Card
                VStack(alignment: .leading, spacing: 16) {
                    // Description with expandable section
                    VStack(alignment: .leading, spacing: 16) {
                        Text(vegetable.descriptionText)
                            .font(.body)
                            .foregroundColor(darkText)
                            .lineSpacing(6)
                        
                        // Quick stats highlights
                        HStack(spacing: 0) {
                            quickStatView(
                                icon: "leaf.fill",
                                value: "\(vegetable.daysToGermination)d",
                                label: "Germination",
                                color: primaryGreen
                            )
                            
                            Divider()
                                .frame(height: 40)
                            
                            quickStatView(
                                icon: "sun.max.fill",
                                value: vegetable.light,
                                label: "Light",
                                color: accentOrange
                            )
                            
                            Divider()
                                .frame(height: 40)
                            
                            quickStatView(
                                icon: "drop.fill",
                                value: vegetable.watering,
                                label: "Water",
                                color: Color.blue
                            )
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(neutralGray)
                        .cornerRadius(16)
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(24)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                    .offset(y: -30)
                }
                .padding(.horizontal)
                
                // MARK: - Section Navigator
                VStack(spacing: 20) {
                    // Custom section selector
                    HStack(spacing: 5) {
                        sectionButton(index: 0, title: "Growing", icon: "leaf.fill")
                        sectionButton(index: 1, title: "Planting", icon: "calendar")
                        sectionButton(index: 2, title: "Harvest", icon: "basket.fill")
                        sectionButton(index: 3, title: "Details", icon: "info.circle")
                    }
                    .padding(8)
                    .background(neutralGray)
                    .cornerRadius(16)
                    
                    // Selected section content
                    Group {
                        switch selectedSection {
                        case 0:
                            growingInfoView
                        case 1:
                            plantingInfoView
                        case 2:
                            harvestInfoView
                        case 3:
                            detailsInfoView
                        default:
                            growingInfoView
                        }
                    }
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.2), value: selectedSection)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                if !isImageExpanded {
                    Text(vegetable.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
            }
        }
    }
    
    // MARK: - Section Button
    private func sectionButton(index: Int, title: String, icon: String) -> some View {
        Button(action: {
            withAnimation {
                selectedSection = index
            }
        }) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: selectedSection == index ? .bold : .regular))
                Text(title)
                    .font(.system(size: 12, weight: selectedSection == index ? .semibold : .regular))
            }
            .foregroundColor(selectedSection == index ? primaryGreen : lightText)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                selectedSection == index ?
                    primaryGreen.opacity(0.15) :
                    Color.clear
            )
            .cornerRadius(12)
        }
    }
    
    // MARK: - Quick Stat View
    private func quickStatView(icon: String, value: String, label: String, color: Color) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(color)
            
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(darkText)
            
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(lightText)
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Growing Info View
    private var growingInfoView: some View {
        VStack(spacing: 20) {
            // Environment Card
            cardView(title: "Growing Environment", icon: "sun.and.horizon.fill") {
                VStack(spacing: 16) {
                    // Top row
                    HStack(spacing: 12) {
                        infoCardView(
                            title: "Light Needs",
                            value: vegetable.light,
                            icon: "sun.max.fill",
                            color: accentOrange
                        )
                        
                        infoCardView(
                            title: "Watering",
                            value: vegetable.watering,
                            icon: "drop.fill",
                            color: Color.blue
                        )
                    }
                    
                    // Bottom row
                    HStack(spacing: 12) {
                        infoCardView(
                            title: "Soil Temperature",
                            value: vegetable.growingSoilTemp,
                            icon: "thermometer",
                            color: Color.red
                        )
                        
                        infoCardView(
                            title: "pH Range",
                            value: vegetable.phRange,
                            icon: "waveform.path.ecg",
                            color: Color.purple
                        )
                    }
                }
            }
            
            // Spacing Card
            cardView(title: "Spacing", icon: "arrow.left.and.right") {
                infoCardView(
                    title: "Bed Spacing",
                    value: vegetable.spacingBeds,
                    icon: "ruler",
                    color: Color.indigo,
                    fullWidth: true
                )
            }
            
            // Growing Timeline
            cardView(title: "Growth Timeline", icon: "clock.fill") {
                VStack(spacing: 16) {
                    timelineItemView(
                        phase: "Germination",
                        duration: "\(vegetable.daysToGermination) days",
                        icon: "1.circle.fill",
                        description: "Seeds typically sprout when soil temperature is \(vegetable.germinationSoilTemp).",
                        isFirst: true
                    )
                    
                    timelineItemView(
                        phase: "Growing",
                        duration: "Ongoing care",
                        icon: "2.circle.fill",
                        description: vegetable.growingDescription.isEmpty ? "No specific instructions." : String(vegetable.growingDescription.prefix(100)) + (vegetable.growingDescription.count > 100 ? "..." : "")
                    )
                    
                    timelineItemView(
                        phase: "Harvest from Seedlings",
                        duration: "\(vegetable.daysToHarvestSeedlings) days",
                        icon: "3.circle.fill",
                        description: "Earlier harvest when starting from seedlings."
                    )
                    
                    timelineItemView(
                        phase: "Harvest from Seeds",
                        duration: "\(vegetable.daysToHarvestSeeds) days",
                        icon: "4.circle.fill",
                        description: "Full maturity when starting from seeds.",
                        isLast: true
                    )
                }
            }
            
            // Companions Card
            cardView(title: "Companion Planting", icon: "person.2.fill") {
                VStack(spacing: 16) {
                    companionItemView(
                        title: "Good Companions",
                        plants: vegetable.goodCompanions,
                        icon: "hand.thumbsup.fill",
                        color: primaryGreen
                    )
                    
                    Divider()
                    
                    companionItemView(
                        title: "Bad Companions",
                        plants: vegetable.badCompanions,
                        icon: "hand.thumbsdown.fill",
                        color: Color.red
                    )
                }
            }
        }
    }
    
    // MARK: - Planting Info View
    private var plantingInfoView: some View {
        VStack(spacing: 20) {
            // Sowing Basics Card
            cardView(title: "Sowing Basics", icon: "seed.fill") {
                VStack(spacing: 16) {
                    // Top row
                    HStack(spacing: 12) {
                        infoCardView(
                            title: "Seed Depth",
                            value: vegetable.seedDepth,
                            icon: "arrow.down",
                            color: Color.brown
                        )
                        
                        infoCardView(
                            title: "Germination Temp",
                            value: vegetable.germinationSoilTemp,
                            icon: "thermometer",
                            color: Color.red
                        )
                    }
                    
                    // Bottom row
                    HStack(spacing: 12) {
                        infoCardView(
                            title: "Sow Indoors",
                            value: vegetable.sowIndoors.isEmpty ? "Not specified" : vegetable.sowIndoors,
                            icon: "house.fill",
                            color: primaryGreen
                        )
                        
                        infoCardView(
                            title: "Sow Outdoors",
                            value: vegetable.sowOutdoors.isEmpty ? "Not specified" : vegetable.sowOutdoors,
                            icon: "cloud.sun.fill",
                            color: accentOrange
                        )
                    }
                }
            }
            
            // Detailed Sowing Instructions
            cardView(title: "Sowing Instructions", icon: "text.book.closed.fill") {
                if vegetable.sowingDescription.isEmpty {
                    emptyStateView(
                        icon: "exclamationmark.triangle",
                        message: "No detailed sowing instructions available for this vegetable."
                    )
                } else {
                    Text(vegetable.sowingDescription)
                        .font(.body)
                        .foregroundColor(darkText)
                        .lineSpacing(5)
                }
            }
            
            // Growing Instructions
            cardView(title: "Growing Care", icon: "leaf.fill") {
                if vegetable.growingDescription.isEmpty {
                    emptyStateView(
                        icon: "exclamationmark.triangle",
                        message: "No detailed growing instructions available for this vegetable."
                    )
                } else {
                    Text(vegetable.growingDescription)
                        .font(.body)
                        .foregroundColor(darkText)
                        .lineSpacing(5)
                }
            }
        }
    }
    
    // MARK: - Harvest Info View
    private var harvestInfoView: some View {
        VStack(spacing: 20) {
            // Harvest Timeline Card
            cardView(title: "Harvest Timeline", icon: "calendar") {
                VStack(spacing: 16) {
                    HStack(spacing: 12) {
                        infoCardView(
                            title: "From Seedlings",
                            value: "\(vegetable.daysToHarvestSeedlings) days",
                            icon: "sprout.fill",
                            color: secondaryGreen
                        )
                        
                        infoCardView(
                            title: "From Seeds",
                            value: "\(vegetable.daysToHarvestSeeds) days",
                            icon: "leaf.fill",
                            color: primaryGreen
                        )
                    }
                }
            }
            
            // Harvest Instructions
            cardView(title: "Harvest Instructions", icon: "scissors") {
                if vegetable.harvestDescription.isEmpty {
                    emptyStateView(
                        icon: "exclamationmark.triangle",
                        message: "No detailed harvest instructions available for this vegetable."
                    )
                } else {
                    Text(vegetable.harvestDescription)
                        .font(.body)
                        .foregroundColor(darkText)
                        .lineSpacing(5)
                }
            }
            
            // Health Benefits
            cardView(title: "Health Benefits", icon: "heart.fill") {
                if vegetable.healthBenefits.isEmpty {
                    emptyStateView(
                        icon: "exclamationmark.triangle",
                        message: "No health benefits information available for this vegetable."
                    )
                } else {
                    Text(vegetable.healthBenefits)
                        .font(.body)
                        .foregroundColor(darkText)
                        .lineSpacing(5)
                }
            }
            
            // Culinary Uses (Placeholder - assuming this could be added later)
            cardView(title: "Culinary Uses", icon: "fork.knife") {
                emptyStateView(
                    icon: "plus.circle",
                    message: "Culinary information could be added here in future updates."
                )
            }
        }
    }
    
    // MARK: - Details Info View
    private var detailsInfoView: some View {
        VStack(spacing: 20) {
            // Basic Info Card
            cardView(title: "Basic Information", icon: "info.circle") {
                VStack(spacing: 12) {
                    detailRow(label: "Vegetable ID", value: "\(vegetable.vegetableId)")
                    detailRow(label: "Vegetable Code", value: vegetable.vegetableCode)
                    detailRow(label: "Catalog ID", value: "\(vegetable.catalogId)")
                    detailRow(label: "Season", value: vegetable.season)
                    if let active = vegetable.active {
                        detailRow(label: "Status", value: active ? "Active" : "Inactive")
                    }
                }
            }
            
            // Technical Details Card
            cardView(title: "Technical Details", icon: "gearshape.2.fill") {
                VStack(spacing: 12) {
                    detailRow(label: "pH Range", value: vegetable.phRange)
                    detailRow(label: "Germination Soil Temp", value: vegetable.germinationSoilTemp)
                    detailRow(label: "Growing Soil Temp", value: vegetable.growingSoilTemp)
                    detailRow(label: "Seed Depth", value: vegetable.seedDepth)
                    detailRow(label: "Days to Germination", value: "\(vegetable.daysToGermination)")
                    detailRow(label: "Days to Harvest (Seeds)", value: "\(vegetable.daysToHarvestSeeds)")
                    detailRow(label: "Days to Harvest (Seedlings)", value: "\(vegetable.daysToHarvestSeedlings)")
                }
            }
            
            // All Properties Card (for developers)
            cardView(title: "All Properties", icon: "list.bullet") {
                VStack(spacing: 12) {
                    DetailAccordion(title: "View All Properties") {
                        VStack(spacing: 8) {
                            Group {
                                detailRow(label: "vegetableId", value: "\(vegetable.vegetableId)")
                                detailRow(label: "vegetableCode", value: vegetable.vegetableCode)
                                detailRow(label: "catalogId", value: "\(vegetable.catalogId)")
                                detailRow(label: "name", value: vegetable.name)
                                detailRow(label: "seedDepth", value: vegetable.seedDepth)
                                detailRow(label: "germinationSoilTemp", value: vegetable.germinationSoilTemp)
                                detailRow(label: "daysToGermination", value: "\(vegetable.daysToGermination)")
                                detailRow(label: "sowIndoors", value: vegetable.sowIndoors)
                                detailRow(label: "sowOutdoors", value: vegetable.sowOutdoors)
                                detailRow(label: "phRange", value: vegetable.phRange)
                            }
                            
                            Group {
                                detailRow(label: "growingSoilTemp", value: vegetable.growingSoilTemp)
                                detailRow(label: "spacingBeds", value: vegetable.spacingBeds)
                                detailRow(label: "watering", value: vegetable.watering)
                                detailRow(label: "light", value: vegetable.light)
                                detailRow(label: "goodCompanions", value: vegetable.goodCompanions)
                                detailRow(label: "badCompanions", value: vegetable.badCompanions)
                                detailRow(label: "season", value: vegetable.season)
                                detailRow(label: "daysToHarvestSeeds", value: "\(vegetable.daysToHarvestSeeds)")
                                detailRow(label: "daysToHarvestSeedlings", value: "\(vegetable.daysToHarvestSeedlings)")
                                if let active = vegetable.active {
                                    detailRow(label: "active", value: active ? "true" : "false")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Reusable Components
    
    // Card View Container
    private func cardView<Content: View>(title: String, icon: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            // Card header
            HStack {
                Image(systemName: icon)
                    .font(.headline)
                    .foregroundColor(primaryGreen)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(darkText)
            }
            
            // Card content
            content()
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 2)
    }
    
    // Info Card View
    private func infoCardView(title: String, value: String, icon: String, color: Color, fullWidth: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.subheadline)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(lightText)
            }
            
            Text(value)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(darkText)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
        }
        .padding(14)
        .frame(maxWidth: fullWidth ? .infinity : nil)
        .background(neutralGray)
        .cornerRadius(12)
        .frame(maxWidth: fullWidth ? .infinity : .infinity)
    }
    
    // Timeline Item View
    private func timelineItemView(phase: String, duration: String, icon: String, description: String, isFirst: Bool = false, isLast: Bool = false) -> some View {
        HStack(alignment: .top, spacing: 16) {
            // Timeline indicator
            VStack(spacing: 0) {
                if !isFirst {
                    Rectangle()
                        .fill(primaryGreen.opacity(0.3))
                        .frame(width: 2)
                        .frame(height: 20)
                }
                
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(primaryGreen)
                    .frame(width: 30, height: 30)
                
                if !isLast {
                    Rectangle()
                        .fill(primaryGreen.opacity(0.3))
                        .frame(width: 2)
                        .frame(height: 40)
                }
            }
            .frame(width: 30)
            
            // Content
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(phase)
                        .font(.headline)
                        .foregroundColor(darkText)
                    
                    Spacer()
                    
                    Text(duration)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(primaryGreen)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(primaryGreen.opacity(0.1))
                        .cornerRadius(6)
                }
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(lightText)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    
    // Companion Item View
    private func companionItemView(title: String, plants: String, icon: String, color: Color) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.headline)
                .foregroundColor(color)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(color)
                
                Text(plants)
                    .font(.subheadline)
                    .foregroundColor(lightText)
                    .lineSpacing(4)
            }
        }
    }
    
    // Detail Row
    private func detailRow(label: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(lightText)
                .frame(width: 140, alignment: .leading)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(darkText)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.vertical, 4)
    }
    
    // Empty State View
    private func emptyStateView(icon: String, message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(lightText)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(lightText)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
    }
    
    // Detail Accordion Component
    struct DetailAccordion<Content: View>: View {
        let title: String
        @ViewBuilder let content: () -> Content
        @State private var isExpanded = false
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Button(action: {
                    withAnimation(.spring()) {
                        isExpanded.toggle()
                    }
                }) {
                    HStack {
                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .font(.caption)
                    }
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.35))
                    .padding(10)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.97))
                    .cornerRadius(8)
                }
                
                if isExpanded {
                    content()
                        .padding(.leading, 8)
                        .transition(.opacity)
                }
            }
        }
    }
}

#Preview {
    VegetableDetailScreen(vegetable: PreviewData.loadVegetables()[0])
}
