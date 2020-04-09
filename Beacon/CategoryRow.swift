//
//  CategoryRow.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-05.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [Emergency]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(self.categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 0) {
                    ForEach(self.items) { emergency in
                        NavigationLink(
                            destination: ActionDetail(
                                emergency: emergency
                            )
                        ) {
                            CategoryItem(emergency: emergency)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}


struct CategoryItem: View {
    var emergency: Emergency
    var body: some View {
        VStack(alignment: .leading) {
            emergency.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(emergency.name)
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(
            categoryName: emergencyData[0].category.rawValue,
            items: Array(emergencyData.prefix(4))
        )
    }
}
