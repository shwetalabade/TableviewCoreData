//
//  ViewController.swift
//  coredataDemo1
//
//  Created by Mac on 09/10/34.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet var MyTableView: UITableView!
    var country: UITextField!
    var cData = [Countrydata]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MyTableView.dataSource = self
        MyTableView.delegate = self
        MyTableView.reloadData()
        
    }


    @IBAction func addNewdata(_ sender: Any) {
        let dialogMessage = UIAlertController(title: "Add data", message: "Enter country", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ok", style: .default){ (action) in
            
            let newCountryName=self.country.text!
            let dh = DatabaseHandler()
            dh.saveData(cName: newCountryName)
            self.cData = dh.fetchdata()
            self.MyTableView.reloadData()
    }
      //  let cancleAction = UIAlertController(nibName: "Cancle",bundle: .cancel)
        let  cancleAction = UIAlertAction(title: "cancle", style: .cancel)   {(action) in
        print("cancelled the operation")
        }
        dialogMessage.addAction(okAction)
        dialogMessage.addAction(cancleAction)
        dialogMessage.addTextField   {(textfield) in
            self.country = textfield
            self.country.placeholder = "Type country name"
        }
        
        self.present(dialogMessage,animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cData.count
    }
    
        
        
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vc = self.MyTableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        vc.textLabel?.text = cData[indexPath.row].countryname
        return vc
        
    }
    
    
}

