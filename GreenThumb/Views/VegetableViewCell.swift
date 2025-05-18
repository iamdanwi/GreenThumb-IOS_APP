//
//  VegetableViewCell.swift
//  GreenThumb
//
//  Created by Dainwi on 25/04/25.
//

import SwiftUI

struct VegetableViewCell: View {
    let vegetable: Vegetable

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Thumbnail Image
            AsyncImage(url: URL(string: vegetable.thumbnailImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .shadow(radius: 3)
            } placeholder: {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 70, height: 70)
                    .overlay(Text("🥕"))
            }

            // Content
            VStack(alignment: .leading, spacing: 6) {
                Text(vegetable.name)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(vegetable.descriptionText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                HStack(spacing: 10) {
                    Label(vegetable.light, systemImage: "sun.max.fill")
                        .font(.caption)
                        .foregroundColor(.orange)

                    Label("\(vegetable.daysToHarvestSeeds)d", systemImage: "calendar")
                        .font(.caption)
                        .foregroundColor(.green)

                    if let active = vegetable.active {
                        Label(active ? "Active" : "Inactive", systemImage: "leaf")
                            .font(.caption)
                            .foregroundColor(active ? .green : .gray)
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
        )
        .padding(.vertical, 4)
    }
}
#Preview {
    VegetableViewCell(vegetable: PreviewData.loadVegetables()[0])
}
