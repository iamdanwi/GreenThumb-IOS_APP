import SwiftUI

struct VegetableDetailScreen: View {
    let vegetable: Vegetable
    @State private var selectedSection = 0
    @State private var isImageExpanded = false

    private let primaryGreen = Color(red: 0.2, green: 0.6, blue: 0.3)
    private let accentOrange = Color(red: 0.95, green: 0.6, blue: 0.1)
    private let neutralGray = Color(red: 0.95, green: 0.95, blue: 0.97)
    private let darkText = Color(red: 0.2, green: 0.2, blue: 0.25)
    private let lightText = Color(red: 0.5, green: 0.55, blue: 0.6)

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VegetableHeader(vegetable: vegetable, isExpanded: $isImageExpanded)

                descriptionCard

                sectionSelector

                sectionContent
            }
            .padding(.bottom, 30)
        }
        .ignoresSafeArea(edges: .top)
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                if !isImageExpanded {
                    Text(vegetable.name).font(.headline)
                }
            }
        }
    }

    private var descriptionCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(vegetable.descriptionText)
                .font(.body)
                .foregroundColor(darkText)
                .lineSpacing(5)

            HStack(spacing: 0) {
                StatBadge(icon: "leaf.fill", value: "\(vegetable.daysToGermination)d", label: "Germination", color: primaryGreen)
                Divider().frame(height: 40)
                StatBadge(icon: "sun.max.fill", value: vegetable.light, label: "Light", color: accentOrange)
                Divider().frame(height: 40)
                StatBadge(icon: "drop.fill", value: vegetable.watering, label: "Water", color: .blue)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(20)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 5)
        .padding(.horizontal)
        .offset(y: -30)
    }

    private var sectionSelector: some View {
        HStack(spacing: 5) {
            ForEach(0..<4) { index in
                let titles = ["Growing", "Planting", "Harvest", "Details"]
                let icons = ["leaf.fill", "calendar", "basket.fill", "info.circle"]
                sectionButton(index: index, title: titles[index], icon: icons[index])
            }
        }
        .padding(8)
        .background(neutralGray)
        .cornerRadius(16)
        .padding(.horizontal)
    }

    private var sectionContent: some View {
        Group {
            switch selectedSection {
            case 0:
                Text("\nLight: \(vegetable.light)\nWatering: \(vegetable.watering)\nSoil Temp: \(vegetable.growingSoilTemp)\n")
                    .frame(maxWidth: .infinity, alignment: .leading)
            case 1:
                Text("\nSeed Depth: \(vegetable.seedDepth)\nGermination Temp: \(vegetable.germinationSoilTemp)\nSow Indoors: \(vegetable.sowIndoors)\nSow Outdoors: \(vegetable.sowOutdoors)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            case 2:
                Text("\nHarvest from Seedlings: \(vegetable.daysToHarvestSeedlings) days\nHarvest from Seeds: \(vegetable.daysToHarvestSeeds) days\nHealth Benefits: \(vegetable.healthBenefits)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            case 3:
                Text("\n❤️Health Benefits: \(vegetable.healthBenefits)\n \nSeason: \(vegetable.season)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            default:
                EmptyView()
            }
        }
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.2), value: selectedSection)
        .padding(.horizontal)
    }

    private func sectionButton(index: Int, title: String, icon: String) -> some View {
        Button {
            withAnimation { selectedSection = index }
        } label: {
            VStack(spacing: 6) {
                Image(systemName: icon)
                Text(title).font(.system(size: 12))
            }
            .foregroundColor(selectedSection == index ? primaryGreen : lightText)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(selectedSection == index ? primaryGreen.opacity(0.15) : .clear)
            .cornerRadius(12)
        }
    }

    struct StatBadge: View {
        let icon: String
        let value: String
        let label: String
        let color: Color

        var body: some View {
            VStack(spacing: 4) {
                Image(systemName: icon).foregroundColor(color)
                Text(value).font(.footnote).fontWeight(.semibold)
                Text(label).font(.caption).foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
        }
    }

    struct VegetableHeader: View {
        let vegetable: Vegetable
        @Binding var isExpanded: Bool

        private let primaryGreen = Color(red: 0.2, green: 0.6, blue: 0.3)
        private let accentOrange = Color(red: 0.95, green: 0.6, blue: 0.1)
        private let darkText = Color(red: 0.2, green: 0.2, blue: 0.25)
        private let lightText = Color(red: 0.5, green: 0.55, blue: 0.6)
        private let neutralGray = Color(red: 0.95, green: 0.95, blue: 0.97)

        var body: some View {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: vegetable.thumbnailImage)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: isExpanded ? 400 : 280)
                        .clipped()
                } placeholder: {
                    Rectangle()
                        .fill(neutralGray)
                        .frame(height: isExpanded ? 400 : 280)
                        .overlay(ProgressView())
                }
                .onTapGesture {
                    withAnimation { isExpanded.toggle() }
                }

                LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.7)]), startPoint: .center, endPoint: .bottom)
                    .frame(height: isExpanded ? 200 : 140)

                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Spacer()
                        BadgeRow(vegetable: vegetable)
                    }

                    Text(vegetable.name)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 2)

                    Text("Code: \(vegetable.vegetableCode) • Catalog: \(vegetable.catalogId)")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(20)
            }
        }
    }

    struct BadgeRow: View {
        let vegetable: Vegetable

        private let primaryGreen = Color(red: 0.2, green: 0.6, blue: 0.3)
        private let accentOrange = Color(red: 0.95, green: 0.6, blue: 0.1)

        var body: some View {
            HStack(spacing: 8) {
                Badge(icon: "number", label: "ID: \(vegetable.vegetableId)", color: .black.opacity(0.6))
                Badge(icon: "calendar", label: vegetable.season, color: accentOrange)
                if let active = vegetable.active {
                    let statusColor = active ? primaryGreen : Color.red
                    Badge(icon: active ? "checkmark.circle" : "xmark.circle", label: active ? "Active" : "Inactive", color: statusColor)
                }
            }
        }
    }

    struct Badge: View {
        let icon: String
        let label: String
        let color: Color

        var body: some View {
            HStack(spacing: 4) {
                Image(systemName: icon).font(.caption2)
                Text(label).font(.caption)
            }
            .padding(.horizontal, 10).padding(.vertical, 4)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(20)
        }
    }
}

#Preview {
    VegetableDetailScreen(vegetable: PreviewData.loadVegetables()[0])
}
