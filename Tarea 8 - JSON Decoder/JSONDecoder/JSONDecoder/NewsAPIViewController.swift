//
//  NewsAPIViewController.swift
//  JSONDecoder
//
//  Created by Arturo Iván Chávez Gómez on 26/05/21.
//

import UIKit

struct News: Codable {
    var articles: [New]
}

struct New: Codable {
    var title: String
    var description: String?
}

class NewsAPIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var news = [New]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=mx&apiKey=48d50fa1800740d5b32bc87032e61b51"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonRequest = try? decoder.decode(News.self, from: json) {
            news = jsonRequest.articles
            newsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = news[indexPath.row].title
        cell.detailTextLabel?.text = news[indexPath.row].description ?? "No info. :("
        return cell
    }

}
