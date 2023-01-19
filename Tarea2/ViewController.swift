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
    
    func Login1() {
        
        let parameters: [String: Any] = ["user": Username.text, "pass": Password.text]
        
        let postString = "user=\(Username.text!)&pass=\(Password.text!)"
          
          let url = URL(string: "https://superapi.netlify.app/api/login")!
          
          var request = URLRequest(url: url)
          request.httpMethod = "POST" //set http method as POST
          
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        print("error=\(String(describing: error))")
                        return
                    }

                     let httpStatus = response as? HTTPURLResponse
                        print("statusCode should be 200, but is \(httpStatus!.statusCode)")
            print("response = \(String(describing: response))")
                        print(postString)

                    let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            
        }
    
          task.resume()
          
        }
    
    func Login2(){
        
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
                print("Tu puto pájaro")
                
            }
            
        }
        
        
    
        
        
        
        
      }
        
    
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
                print("Usuario o contraseña incorreectos")
            }
            
        }
        task.resume()
        
        
    }


}
   /*
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("error=\(error)")
                    return
                }

                 let httpStatus = response as? HTTPURLResponse
                    print("statusCode should be 200, but is \(httpStatus!.statusCode)")
                    print("response = \(response)")
                    print(postString)

                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString)")

            }
            task.resume()
    
        
     */

    
    
    


