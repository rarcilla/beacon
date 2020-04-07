//
//  EarthquakeAfterList.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-06.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct EarthquakeAfterList: View {
    var emergency: Emergency
    
    
    var body: some View {
                NavigationView {
            List {
                Text(emergency.afterActions[0].step)
                Text(emergency.afterActions[1].step)
                Text(emergency.duringActions[2].step)
                Text(emergency.after)
                .foregroundColor(.secondary)
                .font(.subheadline)
                    .padding()
            }
            .navigationBarTitle("In the Aftermath")
        }
    }
}

struct EarthquakeAfterList_Previews: PreviewProvider {
    static var previews: some View {
        EarthquakeAfterList(emergency: emergencyData[0])
    }
}
