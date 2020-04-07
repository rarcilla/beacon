//
//  ChildHostingController.swift
//  Beacon
//
//  Created by Regina Arcilla on 2020-04-05.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import UIKit
import SwiftUI

class ChildHostingController: UIHostingController<CategoryHome> {

        required init?(coder: NSCoder) {
            super.init(coder: coder,rootView: CategoryHome());
        }

        override func viewDidLoad() {
            super.viewDidLoad()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


