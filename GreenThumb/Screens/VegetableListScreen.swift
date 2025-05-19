//
//  VegetableListScreen.swift
//  GreenThumb
//
//  Created by Dainwi on 25/04/25.
//

import SwiftUI

struct VegetableListScreen: View {
    
    @State private var vegetables: [Vegetable] = []
    
    var body: some View {
        List(vegetables, id: \.vegetableId) { vegetable in NavigationLink{
            VegetableDetailScreen(vegetable: vegetable)
        }label: {
            VegetableViewCell(vegetable: vegetable)
        }
            
        }.listStyle(.plain, )
        .task {
            do{
                let client = VegetableHTTTPClient()
                vegetables = try await client.fetchVegetables()
            }catch {
                print("Failed to fetch vegetables: \(error.localizedDescription)")
            }
        }.navigationTitle("Vegetables")
//        .padding()
    }
}

#Preview {
    NavigationStack {
        VegetableListScreen()
    }
}
