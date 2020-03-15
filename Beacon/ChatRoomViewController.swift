//
//  ChatRoomViewController.swift
//  Beacon
//
//  Created by Regina Arcilla on 2020-03-14.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import MultipeerConnectivity
import MessageKit
import InputBarAccessoryView
import UIKit

struct Message: MessageType {
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
    
}

struct Sender: SenderType {
    var senderId: String
    
    var displayName: String
}

class ChatRoomViewController: MessagesViewController, MCSessionDelegate, MCNearbyServiceAdvertiserDelegate, MCBrowserViewControllerDelegate {
    
    var peerID: MCPeerID!
    var session: MCSession?
    var advertiser: MCNearbyServiceAdvertiser!
    private let appServiceType = "beacon-app"
    var textToSend: String?
    
    var messages: [MessageType] = []
    let refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messageInputBar.delegate = self
        messageInputBar.inputTextView.textColor = .black
 
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showMenu))
        
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        session?.delegate = self
        title = "Chatroom"
    }
    
    func sendMessage() {
        print("entered sendMessage function")
        guard let session = session else { return }

        if let messageData = textToSend?.data(using: .utf8) {
            do {
                try session.send(messageData, toPeers: session.connectedPeers, with: .reliable)
                
                let user = Sender(senderId: String(describing: self.peerID), displayName: self.peerID.displayName)
                
                let message = Message(sender: user, messageId: UUID().uuidString, sentDate: Date(), kind: .text(textToSend!))
                
                insertMessage(message)
            } catch {
                let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
        }
    }
    
}

//extension for MPC
extension ChatRoomViewController {
        // MARK: - MCSessionDelegate Methods
        func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
            switch state {
            case .connected:
                print("\(peerID) has connected.")
            case .connecting:
                print("\(peerID) is connecting.")
            case .notConnected:
                print("\(peerID) is not connected.")
            @unknown default:
                print("state of \(peerID) is unknown.")
            }
        }
        
        func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
            print("entered session didRecieve method")
            DispatchQueue.main.async { [weak self] in
                if let messageString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    
                    let user = Sender(senderId: String(describing: peerID), displayName: peerID.displayName)
                    
                    let message = Message(sender: user, messageId: UUID().uuidString, sentDate: Date(), kind: .text(messageString as String))
                    
                    self?.insertMessage(message)
                }
            }
        }

    func insertMessage(_ message: Message) {
        messages.append(message)
        // Reload last section to update header/footer labels and insert a new one
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([messages.count - 1])
            if messages.count >= 2 {
                messagesCollectionView.reloadSections([messages.count - 2])
            }
        })
    }

        func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        }
        
        func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        }
        
        func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        }
        
        // MARK: - MCBrowserViewControllerDelegate Methods
        
        func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
            dismiss(animated: true)
        }
        
        func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
            dismiss(animated: true)
        }
        
        // MARK: - MCNearbyServiceAdvertiserDelegate Methods
        
        func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
            invitationHandler(true, session)
        }
        
        // MARK: - Hosting/Joining Chat Methods
        
        func hostSession(_ action: UIAlertAction) {
            advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: appServiceType)
            advertiser.delegate = self
            advertiser.startAdvertisingPeer()
        }
        
        func joinSession(_ action: UIAlertAction) {
            guard let session = session else { return }
            let browser = MCBrowserViewController(serviceType: appServiceType, session: session)
            browser.delegate = self
            present(browser, animated: true)
        }
        
        @objc func showMenu() {
            let alert = UIAlertController(title: "Chat Options", message: nil, preferredStyle: .alert)
            
            let hostAction = UIAlertAction(title: "Host a chat", style: .default, handler: hostSession)
            let joinAction = UIAlertAction(title: "Join a chat", style: .default, handler: joinSession)
            
            alert.addAction(hostAction)
            alert.addAction(joinAction)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            present(alert, animated: true)
        }
}

//extension for MessageKit
extension ChatRoomViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    //MARK: - MessagesDataSource Methods
    func currentSender() -> SenderType {
        return Sender(senderId: String(describing: self.peerID), displayName: self.peerID.displayName)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    //MARK: - Text Messages
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        return isFromCurrentSender(message: message) ? .white : UIColor(red: 102, green: 195, blue: 177, alpha: 1.0)
    }
}

extension ChatRoomViewController: MessageInputBarDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        print("inhere")
        self.textToSend = text
        sendMessage()
    }
}
