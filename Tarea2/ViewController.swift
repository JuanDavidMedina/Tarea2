//
//  ViewController.swift
//  Tarea2
//
//  Created by Apps2M on 12/1/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var Username: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    var ArrayUsers: [String] = []

    @IBAction func Login(_ sender: UIButton) {
        let url = URL(string: "https://superapi.netlify.app/api/login")!
        let parameters: [String: Any] = ["user": Username.text, "pass": Password.text]
        var request = URLRequest(url: url)
        let Envio = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpMethod = "POST"
        request.httpBody = Envio
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
                    guard let data = data, error == nil else {
                        print("error=\(String(describing: error))")
                        return
                    }
            if String(data: data, encoding: .utf8) == "Login succesful"{
                DispatchQueue.main.async{
                    self.performSegue(withIdentifier: "Logued", sender: sender)
                }
                
            }else{
                print("Usuario o contraseña incorrectos")
            }
        }
        task.resume()
    }
}
   

    
    
    


