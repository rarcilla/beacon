//
//  ActionRow.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-06.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct ActionRow: View {
    var emergency: Emergency
//    var actionsArray: Array<Action>
    var body: some View {
        VStack {
            Group {
                    HStack {
                    emergency.image
                        .resizable()
                        .frame(width: 50, height: 50)
                        Text(emergency.beforeSteps.first)
                    Spacer()
                }
            }
        }
    }
}

struct ActionRow_Previews: PreviewProvider {
    static var previews: some View {
        ActionRow(emergency: emergencyData[0])
    }
}
