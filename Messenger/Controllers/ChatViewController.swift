//
//  ChatViewController.swift
//  Messenger
//
//  Created by Maha saad on 27/05/1443 AH.
//

import UIKit
import MessageKit
import InputBarAccessoryView

struct Message : MessageType {
    public   var sender : SenderType
    public   var messageId: String
    public   var sentDate: Date
    public   var kind: MessageKind
}
extension MessageKind {
    var messageKindString: String{
        switch self {
        case .text(_):
            return "text"
        case .attributedText(_):
            return "attributed_text"
        case .photo(_):
            return "photo"
        case .video(_):
            return "video"
        case .location(_):
            return "location"
        case .emoji(_):
            return "emoji"
        case .audio(_):
            return "audio"
        case .contact(_):
            return "contact"
        case .linkPreview(_):
            return "link_preview"
        case .custom(_):
            return "custom"
        }
    }
}

struct Sender :SenderType{
    public  var photoURL : String
    public  var senderId: String
    public var displayName: String
 
}

class ChatViewController: MessagesViewController {
    
    public static let dateFormatter: DateFormatter = {
        
        let formattre = DateFormatter()
        formattre.dateStyle = .medium
        formattre.timeStyle = .long
        formattre .locale = .current
        return formattre
        
    }()
    
    public let otherUserEmail : String

    public var isNewConversation = false
    
    private var message = [Message]()
    
    private var selfSender : Sender? {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else{
            return nil
        }
      return  Sender(photoURL: "",
               senderId: email ,
               displayName: "Maha Abdullah")
    }
    
    init(with email : String) {
        self.otherUserEmail = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        view.backgroundColor = .red
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageInputBar.inputTextView.becomeFirstResponder()

    }
}
extension ChatViewController : InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty ,
        let selfSender = self.selfSender ,
        let messageId = createMessageId() else{
            return
        }
        print("sending\(text)")
        //send message
        if isNewConversation {
            
            let mmessage = Message(sender: selfSender,
                                   messageId: messageId,
                                   sentDate: Date(),
                                   kind: .text(text))
            
            // create convo
            DatabaseManager.shared.createNewConversation(with: otherUserEmail, name: self.title ?? "User" , fristMessage: mmessage, completion: { success in
                
                if success {
                    print("message sent")
                }else{
                    print("faield to send")
                }
                
            })
        }
        else {
            //append to existing conversation data
        }
    }
    
    private func createMessageId() -> String? {
        
        guard let currentUserEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            return nil
        }
        let safeCurrentEmail = DatabaseManager.safeEmail(emailAddress: currentUserEmail)
        let dateString = Self.dateFormatter.string(from: Date())
        let newIdentifier = "\(otherUserEmail)_\(safeCurrentEmail)_\(dateString)"
        print("created message id : \(newIdentifier)")
        return newIdentifier
    }
    
}

extension ChatViewController :  MessagesDataSource , MessagesLayoutDelegate , MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        
        if let sender = selfSender {
            return sender
        }
        fatalError("Self Sender is nil , email should be cached")
        
        return Sender(photoURL: "", senderId: "12", displayName: "")
        
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return message[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return message.count
        
    }
    
    
}
