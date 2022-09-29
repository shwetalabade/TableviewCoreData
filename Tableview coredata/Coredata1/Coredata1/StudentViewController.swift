//
//  StudentViewController.swift
//  Coredata1
//
//  Created by Mac on 02/01/25.
//

import UIKit

class StudentViewController: UIViewController {
     
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var UserTableView: UITableView!
    
    var user = [User]()
    var userId: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibFile = UINib(nibName: "StudentTableViewCell", bundle: nil)
        self.UserTableView.register(nibFile, forCellReuseIdentifier: "cell")
        searchBar.delegate = self
        searchBar.layer.borderWidth = 3.0
        searchBar.layer.borderColor = UIColor.blue.cgColor

        // Do any additional setup after loading the view.
    }
    

}
extension StudentViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let vc = self.UserTableView.dequeueReusableCell(withIdentifier: "cell") as? StudentdataTableViewCell
        else{
            return UITableViewCell()
        }
        return vc
          //  vc.nameTF.text = self.User[indexPath.row]
    }
    
    @objc func dismissKeyboard(){
        searchBar.resignFirstResponder()
    }
    
    func searchedFriend(_ seachedText: String) {
        if let userId = userId {
            let dbObj = DBHelper()
            if let User = dbObj.searchUser(searchedText: seachedText, userId: userId){
                self.user = User
                self.UserTableView.reloadData()
            }else{
                print("No matches found!!!")
            }
        }
    }
}
extension StudentViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        guard let searchText = searchBar.text else {
            return
        }
        searchedFriend(searchText)
    }
}

