//
//  ViewController.swift
//  Coredata1
//
//  Created by Mac on 02/01/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nameText: UITextField!
    @IBOutlet var emailIdText: UITextField!
    @IBOutlet var userIdText: UITextField!
    @IBOutlet var phoneNOText: UITextField!
    @IBOutlet var cityText: UITextField!
    @IBOutlet var pincodeText: UITextField!
    var User:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func submitBtn(_ sender: Any) {
        
        guard let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "StudentViewController") as? StudentViewController
         else{
             return
         }
         navigationController?.pushViewController(vc1, animated: true)
        
        guard let user = getData() else {
            return
        }
        let obj = DBHelper()
        obj.createUserTable()
        if ((emailIdText.text?.isValidEmail)!){
            obj.insertValuesUser(user: User!){
                    func showAlert(title : String, message : String, navigate: Bool = false){
                        showAlert(title: "success", message: "Friend added successfully",navigate: true)
                        }
                        }
                      }
                    else{
                        func showAlert(title : String, message : String, navigate: Bool = false){
                     showAlert(title: "ok", message: "Enter email in well format")
            }
          }
        
        }
        func getData()-> User?{
            guard let name = nameText.text else{
                return nil
            }
            guard let emailId = emailIdText.text else{
                return nil
            }
            guard let userId = userIdText.text else{
                return nil
            }
            guard let phoneNO = phoneNOText.text else{
                return nil
            }
            guard let city = cityText.text else{
                return nil
            }
            guard let pincode = pincodeText.text else{
                return nil
            }
            return User
        }
}
        extension String{
            var isValidEmail: Bool {
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3}"
                let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
                return emailTest.evaluate(with: self)
        }
        }
