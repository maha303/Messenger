//
//  NewConversationViewController.swift
//  Messenger
//
//  Created by Maha saad on 25/05/1443 AH.
//

import UIKit
import JGProgressHUD

class NewConversationViewController: UIViewController {
    private let spinner = JGProgressHUD()
    
    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for Users ..."
        return searchBar
    }()
    private let tableView : UITableView = {
       let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    private let noResultsLabel :UILabel  = {
       let lable = UILabel()
        lable.isHidden = true
        lable.text = "No Resulte"
        lable.textAlignment = .center
        lable.textColor = .green
        lable.font = .systemFont(ofSize: 21 , weight : .medium)
        return lable
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(dismissSelf))
        
        searchBar.becomeFirstResponder()
 
    }
    
    @objc private func dismissSelf(){
        dismiss(animated: true, completion: nil)
    }

}
extension NewConversationViewController : UISearchBarDelegate {
    
    func searchBarButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
}
