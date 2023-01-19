//
//  RegisterViewController.swift
//  Tarea2
//
//  Created by Apps2M on 12/1/23.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var NewPassword: UITextField!
    
    @IBOutlet weak var ConfirmPassword: UITextField!
    
    @IBOutlet weak var NewUser: UITextField!
    
  func CreateUser(){
        
    
      let parameters: [String: Any] = ["user": NewUser.text, "pass": NewPassword.text]
      
    let url = URL(string: "https://superapi.netlify.app/api/register")!

      let session = URLSession.shared
      var request = URLRequest(url: url)
      request.httpMethod = "POST" //set http method as POST
      request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
      request.addValue("application/json", forHTTPHeaderField: "Accept")
      
      do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      } catch let error {
        print(error.localizedDescription)
        return
      }
      
      let task = session.dataTask(with: request) { data, response, error in
        
        if let error = error {
          print("Post Request Error: \(error.localizedDescription)")
          return
        }
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
          print("Invalid Response received from the server")
          return
        }
        guard let responseData = data else {
          print("nil Data received from the server")
          return
        }
        
        do {
          if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
            print(jsonResponse)
            // handle json response
          } else {
            print("data maybe corrupted or in wrong format")
            throw URLError(.badServerResponse)
          }
        } catch let error {
          print(error.localizedDescription)
        }
      }
      task.resume()
    }



    
    @IBAction func NewAccount(_ sender: UIButton) {
        
        if NewPassword.text == ConfirmPassword.text{
            print("Contraseña validada")
            CreateUser()
            self.performSegue(withIdentifier: "UserCreation", sender: sender)
            
        }
        
        else if NewPassword.text != ConfirmPassword.text{
            print("Contraseña erronea")
        }
    }
    
        
    
    
    
   
}

    

