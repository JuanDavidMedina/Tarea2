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
    
    var newUsername: String = ""
    var newPassword: String = ""
    var newConfirm: String = ""
    
    
    @IBAction func NewUsername(_ sender: UITextField) {
        newUsername = sender.text!
        print(newUsername)
    }
    
    
    @IBAction func NewPassword(_ sender: UITextField) {
        newPassword = sender.text!
        print(newPassword)
    }
    
    @IBAction func ConfirmPassword(_ sender: UITextField) {
        newConfirm = sender.text!
        print(newConfirm)
    }
    
    
    func CreateUser(){
        
    
        let parameters: [String: Any] = ["user": newUsername, "pass": newPassword]
      
      // create the url with URL
      let url = URL(string: "https://superapi.netlify.app/api/register")! // change server url accordingly
      
      // create the session object
      let session = URLSession.shared
      
      // now create the URLRequest object using the url object
      var request = URLRequest(url: url)
      request.httpMethod = "POST" //set http method as POST
      
      // add headers for the request
      request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
      request.addValue("application/json", forHTTPHeaderField: "Accept")
      
      do {
        // convert parameters to Data and assign dictionary to httpBody of request
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      } catch let error {
        print(error.localizedDescription)
        return
      }
      
      // create dataTask using the session object to send data to the server
      let task = session.dataTask(with: request) { data, response, error in
        
        if let error = error {
          print("Post Request Error: \(error.localizedDescription)")
          return
        }
        
        // ensure there is valid response code returned from this HTTP response
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
          print("Invalid Response received from the server")
          return
        }
        
        // ensure there is data returned
        guard let responseData = data else {
          print("nil Data received from the server")
          return
        }
        
        do {
          // create json object from data or use JSONDecoder to convert to Model stuct
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
      // perform the task
      task.resume()
    }



    @IBAction func NewAccount(_ sender: UIButton) {
        
        
        if newPassword == newConfirm{
            self.performSegue(withIdentifier: "JugarDeNuevoLose", sender: sender)
            
        }
        
        else{
            print("Contraseña erronea")
        }
    }
    
    
   
}

    

