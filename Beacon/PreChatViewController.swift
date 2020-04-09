//
//  NewViewController.swift
//  Beacon
//
//  Created by Regina Arcilla on 2020-03-14.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import MultipeerConnectivity
import UIKit

class PreChatViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var nameStackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var displayName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.displayNameTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        sendButton.isEnabled = false
        sendButton.alpha = 0.5
                
        setupBackground()
        setupLayout()
    }
    
    @IBAction func displayNameTextFieldChanged(_ sender: UITextField) {
        if let text = sender.text {
            if text.count > 0 {
                self.displayName = text
                sendButton.isEnabled = true
                sendButton.alpha = 1
            } else {
                self.displayName = ""
                sendButton.isEnabled = false
                sendButton.alpha = 0.5
            }
        } else {
            sendButton.isEnabled = false
            sendButton.alpha = 0.5
        }
    }
    
    func setupBackground() {
        let background = UIImage(named: "prechatBackground")
        
        var imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func setupLayout(){
        let margins = view.layoutMarginsGuide
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: nameStackView.topAnchor, constant: -50),
            nameStackView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            nameStackView.topAnchor.constraint(equalTo: margins.centerYAnchor, constant: -85),
            nameStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            displayNameTextField.widthAnchor.constraint(equalTo: nameStackView.widthAnchor, multiplier: 0.75),
            displayNameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            sendButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            sendButton.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 30)
        ])
        
        sendButton.layer.cornerRadius = 4
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        displayNameTextField.resignFirstResponder()
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ChatRoomViewController {
            dest.peerID = MCPeerID(displayName: self.displayName)
        }
    }
}
