//
//  ActionList.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-06.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct ActionList: View {
    var emergency: Emergency
    
    var body: some View {
        
        
        
        NavigationView {
            NavigationLink(destination: ActionDetail(emergency: emergency)) {
                ActionRow(emergency: emergency)
        }
        .navigationBarTitle(Text("Actions"))
        }
    }
}

struct ActionList_Previews: PreviewProvider {
    static var previews: some View {
        ActionList(emergency: emergencyData[0])
    }
}

