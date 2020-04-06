//
//  EmergencyRow.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-03.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct EmergencyRow: View {
    var emergency: Emergency
    
    var body: some View {
        HStack {
            emergency.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(emergency.name)
            Spacer()
        }
    }
}

struct EmergencyRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmergencyRow(emergency: emergencyData[0])
            EmergencyRow(emergency: emergencyData[1])
            EmergencyRow(emergency: emergencyData[2])
            EmergencyRow(emergency: emergencyData[3])
        }
        .previewLayout(.fixed(width:300, height: 70))
    }
}

