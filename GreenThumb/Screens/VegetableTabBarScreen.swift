//
//  VegetableTabBarScreen.swift
//  GreenThumb
//
//  Created by Dainwi on 25/04/25.
//

import SwiftUI

struct VegetableTabBarScreen: View {
    var body: some View {
        TabView{
            NavigationStack{
                VegetableListScreen()
            }.tabItem{
                    Image(systemName: "leaf")
                    Text("Vegetable")
            }
            NavigationStack{
                Text("MyGardenScreen")
            }.tabItem {
                    Image(systemName: "house")
                    Text("My Garden")
            }
            
            NavigationStack{
                Text("Bug")
            }.tabItem {
                    Image(systemName: "ladybug")
                    Text("Pests")
            }
        }
    }
}

#Preview {
    VegetableTabBarScreen()
}
