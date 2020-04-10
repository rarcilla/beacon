//
//  MapDetail.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-10.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct MapDetail: View {
    var emergency: Emergency
    
    var body: some View {
        VStack {
            MapView(coordinate: emergency.locationCoordinate)
                .frame(height: 300)
                .edgesIgnoringSafeArea(.top)
                
            CircleImage(image: emergency.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text(emergency.name)
                    .font(.title)
                    HStack(alignment: .top){
                        Text(emergency.regionalInfo)
                            .font(.subheadline)
                        Spacer()
                        Text(emergency.category.rawValue)
                            .font(.subheadline)
                }
            }
            .padding()
        }
    }
}

struct MapDetail_Previews: PreviewProvider {
    static var previews: some View {
        EmergUIDetail(emergency: emergencyData[1])
    }
}
