//
//  ActionDetail.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-06.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

//struct ActionDetail: View {
//    var emergency: Emergency
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(emergency.name)
//                .font(.title)
//    }
//        .navigationBarTitle(Text(emergency.name))
//}
//}

struct ActionDetail: View {
    var emergency: Emergency
    
    var body: some View {
        ScrollView {
           GeometryReader { geometry in
               ZStack {
                   if geometry.frame(in: .global).minY <= 0 {
                    self.emergency.image
                        .resizable()
                       .aspectRatio(contentMode: .fill)
                       .frame(width: geometry.size.width, height: geometry.size.height)
                       .offset(y: geometry.frame(in: .global).minY/9)
                       .clipped()
                   } else {
                    self.emergency.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                        .clipped()
                        .offset(y: -geometry.frame(in: .global).minY)
                   }
               }
           }
           .frame(height: 350)
            VStack(alignment: .leading) {
                Text(emergency.name)
                    .font(.custom("AvenirNext-Bold", size: 30))
                    .lineLimit(nil)
                    .padding(.top, 1)
                Text(emergency.generalInfo)
                    .font(.custom("AvenirNext-Regular", size: 15))
                    .multilineTextAlignment(.leading)
                    .padding(.top, 10)
                    .lineLimit(nil)
                Text(emergency.regionalInfo)
                    .font(.custom("AvenirNext-Regular", size: 12))
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                    .lineLimit(nil)
            }
            .frame(width: 350)
        }
    }
}
struct ActionDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActionDetail(emergency: emergencyData[1])
    }
}


