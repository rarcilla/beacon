//
//  NewViewController.swift
//  Beacon
//
//  Created by Regina Arcilla on 2020-03-14.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import MultipeerConnectivity
import UIKit

class PreChatViewController: UIViewController {
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    var displayName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func displayNameTextFieldChanged(_ sender: UITextField) {
        if let text = sender.text {
            self.displayName = text
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ChatRoomViewController {
            dest.peerID = MCPeerID(displayName: displayName)
        }
    }
    

}
