//
//  TabBarController.swift
//  Beacon
//
//  Created by Regina Arcilla on 2020-04-05.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import UIKit
import SwiftUI

class TestTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedIndex = 1
        
        
        let item = UITabBarItem()
        item.title = "Chat"
        item.image = UIImage(named: "chat_icon")
        
        var chatController = self.viewControllers![0] as! UIViewController

        chatController.tabBarItem = item
        
        let item2 = UITabBarItem()
        item2.title = "Emergency Info"
        item2.image = UIImage(named: "info_icon")
        
        var infoController = self.viewControllers![1] as! UIViewController

        infoController.tabBarItem = item2
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
