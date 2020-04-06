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
                .frame(height: 300)
            
            CircleImage(image: emergency.image)
                .offset(x: 0, y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text(emergency.name)
                    .font(.title)
                
                HStack(alignment: .top){
                    Text(emergency.act)
                        .font(.subheadline)
                    Spacer()
                    Text(emergency.province)
                        .font(.subheadline)
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
        EmergUIDetail(emergency: emergencyData[0])
    }
}
