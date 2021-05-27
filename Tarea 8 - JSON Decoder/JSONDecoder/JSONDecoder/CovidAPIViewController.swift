//
//  CovidAPIViewController.swift
//  JSONDecoder
//
//  Created by Arturo Iván Chávez Gómez on 26/05/21.
//

import UIKit

struct Object: Codable {
    var country: String
    var cases: Int?
    var deaths: Int?
}

class CovidAPIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var covidTableView: UITableView!
    
    var objects = [Object]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://corona.lmao.ninja/v3/covid-19/countries"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonRequest = try? decoder.decode([Object].self, from: json) {
            
            self.objects = jsonRequest
            
            covidTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = covidTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = objects[indexPath.row].country
        cell.detailTextLabel?.text = "Currently cases: \(objects[indexPath.row].cases ?? 0)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
}
