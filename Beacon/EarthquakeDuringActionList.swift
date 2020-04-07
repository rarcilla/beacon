//
//  EarthquakeDuringActionList.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-06.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct EarthquakeDuringActionList: View {
    var emergency: Emergency
    
    
    var body: some View {
                NavigationView {
            List {
                Text(emergency.duringActions[0].step)
                Text(emergency.duringActions[1].step)
                Text(emergency.duringActions[2].step)
                Text(emergency.during)
                .foregroundColor(.secondary)
                .font(.subheadline)
                    .padding()
                
            }
            .navigationBarTitle("During An Earthquake")
        }
    }
}

struct EarthquakeDuringActionList_Previews: PreviewProvider {
    static var previews: some View {
        EarthquakeDuringActionList(emergency: emergencyData[0])
    }
}
