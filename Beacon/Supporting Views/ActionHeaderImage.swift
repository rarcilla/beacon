//
//  ActionHeaderImage.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-06.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct ActionHeaderImage: View {
    var image: Image
    
    var body: some View {
        self.image
    }

struct ActionHeaderImage_Previews: PreviewProvider {
    static var previews: some View {
            ActionHeaderImage(image: Image("wildfire"))
        }
    }
}
