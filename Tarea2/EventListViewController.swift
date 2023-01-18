//
//  EventListViewController.swift
//  Tarea2
//
//  Created by Apps2M on 12/1/23.
//

import UIKit

class EventListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ShowOriginalList()
        TableView.dataSource = self
        TableView.delegate = self
        
    }
    var ArrayEvents: [Event] = []
   
    
    
    

    func ShowOriginalList(){
  
        let urlSession = URLSession.shared
        let url = URL(string: "https://superapi.netlify.app/api/db/eventos")
        urlSession.dataTask(with: url!) {
    (data, response, error) in
        
        if let data = data{
            let Events = try? JSONSerialization.jsonObject(with: data)
            
            print(String(describing: Events))
        
            for i in Events as! [[String: Any]] {
                let evento = Event(json:i)
                
                self.ArrayEvents.append(evento)
                print(String(describing: Events))
                
                
                
        
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.TableView.reloadData()
            }
        
        } else {
            print(error)
            }
            

        }.resume()
    
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        
         let celda = tableView.dequeueReusableCell(withIdentifier: "celdaID", for: indexPath) as! CeldaTableViewCell
            let timeInterval = TimeInterval(ArrayEvents[indexPath.row].date / 1000)
            let Datechanged = Date(timeIntervalSince1970: timeInterval)
            
            
            celda.Name.text = ArrayEvents[indexPath.row].name
            celda.Date.text = Datechanged.formatted().description
            
            
            
            
            return celda
        
            
        }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            return ArrayEvents.count
        }
    
    

    
      
}






      
