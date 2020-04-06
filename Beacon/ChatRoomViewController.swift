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
    var status: String?
    
    var messages: [MessageType] = []
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        setupMessageInputBar()
        removeAvatar()

        self.navigationItem.title = "Chatroom (0 peers)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showMenu))
        
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        session?.delegate = self
        title = "Chatroom"
    }
    
    func removeAvatar() {
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
          layout.setMessageIncomingAvatarSize(.zero)
          layout.setMessageOutgoingAvatarSize(.zero)
          layout.setMessageIncomingMessageTopLabelAlignment(LabelAlignment(textAlignment: .left, textInsets: UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)))
          layout.setMessageOutgoingMessageTopLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 18)))
        }
    }
    
    func sendMessage() {
        guard let session = session else { return }

        if let messageData = textToSend?.data(using: .utf8) {
            do {
                try session.send(messageData, toPeers: session.connectedPeers, with: .reliable)
                
                let user = Sender(senderId: String(describing: self.peerID), displayName: self.peerID.displayName)
                let message = Message(sender: user, messageId: UUID().uuidString, sentDate: Date(), kind: .text(textToSend!))
                insertMessage(message)
            } catch MCError.invalidParameter {
                let ac = UIAlertController(title: "Error: your message was not sent.", message: "There are currently no peers in the chatroom to send message to.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            } catch {
                let ac = UIAlertController(title: "Error sending message.", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
        }
    }
        
    func updateTitle(){
        guard let session = session else { return }
        let numberOfPeers = session.connectedPeers.count
        
        DispatchQueue.main.async {
            if numberOfPeers == 1 {
                self.title = "Chatroom (\(numberOfPeers) peer)"
            } else {
                self.title = "Chatroom (\(numberOfPeers) peers)"
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
                updateTitle()
            case .connecting:
                print("\(peerID) is connecting.")
            case .notConnected:
                print("\(peerID) is not connected.")
                updateTitle()
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
    
    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section - 1 >= 0 else { return false }
        return messages[indexPath.section].sender.senderId == messages[indexPath.section - 1].sender.senderId
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .black
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor(red:0.40, green:0.76, blue:0.69, alpha:1.00) : UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.00)
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if indexPath.section % 5 == 0 {
            return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        }
        return nil
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if !isPreviousMessageSameSender(at: indexPath) {
            let name = message.sender.displayName
            return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
        } else {
            return nil
        }
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if isFromCurrentSender(message: message) {
            return isPreviousMessageSameSender(at: indexPath) ? 0 : 20
        } else {
            return isPreviousMessageSameSender(at: indexPath) ? 0 : 20
        }
    }
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if indexPath.section % 5 == 0 && !isPreviousMessageSameSender(at: indexPath) {
            // not the same sender - cellTopLabel is showing
            return 18
        } else {
            //same sender - hide cellTopLabel
            return 0
        }
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
      avatarView.isHidden = true
    }
}

extension ChatRoomViewController: MessageInputBarDelegate {
    func setupMessageInputBar() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.textColor = .black
        messageInputBar.sendButton.setTitleColor(UIColor(red:0.40, green:0.76, blue:0.69, alpha:1.00), for: .normal)
        messageInputBar.sendButton.setTitleColor(UIColor(red:0.40, green:0.76, blue:0.69, alpha:0.3), for: .highlighted)
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        self.textToSend = text
        sendMessage()
        messageInputBar.inputTextView.text = String()
    }
}
