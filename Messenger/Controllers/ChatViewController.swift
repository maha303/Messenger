//
//  ChatViewController.swift
//  Messenger
//
//  Created by Maha saad on 27/05/1443 AH.
//

import UIKit
import MessageKit

struct Message : MessageType {
    var sender : SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct Sender :SenderType{
    var photoURL : String
    var senderId: String
    var displayName: String
 
}

class ChatViewController: MessagesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self

    }
}

extension ChatViewController :  MessagesDataSource , MessagesLayoutDelegate , MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        <#code#>
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        <#code#>
    }
    
    
}
