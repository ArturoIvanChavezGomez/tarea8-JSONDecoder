//
//  ViewController.swift
//  JSONDecoder
//
//  Created by Arturo Iván Chávez Gómez on 26/05/21.
//

import UIKit

struct Request: Codable {
    var title: String
    var body: String
}

struct Requests: Codable {
    var results: [Request]
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var requests = [Request]()
    
    @IBOutlet weak var jsonTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonRequests = try? decoder.decode(Requests.self, from: json) {
            requests = jsonRequests.results
            jsonTableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = jsonTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = requests[indexPath.row].title
        cell.detailTextLabel?.text = requests[indexPath.row].body
        return cell
    }
    
}

