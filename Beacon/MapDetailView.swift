//
//  EmergUIDetail.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-03.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct MapDetailView: View {
    var emergency: Emergency
    
    var body: some View {
        VStack {
            MapView(coordinate: emergency.locationCoordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 200)
            
            CircleImage(image: emergency.image)
                .offset(x: 0, y: -50)
            VStack(alignment: .leading) {
                
                Text(emergency.name)
                    .font(.title)
                    
                Group {
                    HStack(alignment: .top){
                        Text(emergency.city)
                            .font(.subheadline)
                        Spacer()
                        Text(emergency.category.rawValue)
                            .font(.subheadline)
                    }
                }
            }
            .padding()
            .background(Color("BeaconYellow"))
            Spacer()
            Text(emergency.regionalInfo)
            .padding()
        }
        .navigationBarTitle(Text(emergency.name), displayMode: .inline)
    }
}

struct MapDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MapDetailView(emergency: emergencyData[2])
    }
}
