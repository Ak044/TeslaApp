//
//  SecondViewController.swift
//
//
//  Created by Ali Boshehri on 4/7/19.
//

import UIKit
import TeslaKit


var password = ""
var email = ""

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    //Instansiate API
    let teslaAPI = TeslaAPI()
    

    
    
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    @IBAction func helpButton(_ sender: Any) {
       
        // setup the help button
        let alert = UIAlertController(title: "Help", message: "Please log in with your Tesla username and password", preferredStyle: .alert)
        alert.addAction(title: "OK", color: UIColor.blue, style: .default, isEnabled: true, handler: nil)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        Enter.layer.cornerRadius = 10.0
        
        UserName.delegate = self
        Password.delegate = self
        
        // hide navigation bar
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    @IBAction func Enter(_ sender: Any) {
        
//        TextView.text = "Username: \(UserName.text!)\nPassword:\(Password.text!)"
        
        email = (UserName.text!)
        password = (Password.text!)
        
        //Code to send the data to the server
        let url = URL(string: "http://www.thisismylink.com/postName.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
       let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
//        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        //Code to send the data to the server
        
        print("Hello, THIS IS BEFORE THE USERNAME AND PASSWORD ARE ENTERED")
        UserDefaults.standard.set(self.UserName.text!, forKey: "username")
        UserDefaults.standard.set(self.Password.text!, forKey: "password")
        
        
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            Password.resignFirstResponder()
        }
        
        // present main page ViewController
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        viewController.finalEmail = UserName.text!
        viewController.finalPassword = Password.text!
        let navController = UINavigationController(rootViewController: viewController)
        AppData.sharedInstance.appDelegate.window?.rootViewController = navController
        
    }
    

}
// this is needed for sending data to server
extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}
// you need this extension for sending data to server
extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
    
}
