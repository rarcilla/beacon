//
//  EmergUIDetail.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-03.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct EmergUIDetail: View {
    var emergency: Emergency
    
    var body: some View {
        VStack {
            MapView(coordinate: emergency.locationCoordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 200)
            
            CircleImage(image: emergency.image)
                .offset(x: 0, y: -150)
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
            Spacer()
        }
        .navigationBarTitle(Text(emergency.name), displayMode: .inline)
    }
}

struct EmergUIDetail_Previews: PreviewProvider {
    static var previews: some View {
        EmergUIDetail(emergency: emergencyData[2])
    }
}
