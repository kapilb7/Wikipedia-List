//
//  ViewController.swift
//  Wikipedia List
//
//  Created by Kapil on 02/02/21.
//

import UIKit
import Kingfisher

class ViewController: UITableViewController {
    
    private let cellReuseIdentifier = "Cell"
    private var wikis: Wiki?
    
    private let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=19.018391%7C72.863213&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
    
    //"https://en.wikipedia.org/api/rest_v1/page/summary/Wadala"
    
    private var pages = [Page]()
    var bv: [Int : Page]?
    var titles = [String]()
    var images = [String]()
    var desc = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Near me"
        registerTableViewCell()
        fetchNearbyPlaces()
    }

    private func registerTableViewCell() {
        tableView.register(CustomCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func fetchNearbyPlaces() {
        guard let url = URL(string: urlString) else {
            assertionFailure("Bad URL: \(urlString)")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let wiki = try? JSONDecoder().decode(Wiki.self, from: data)
            
            self.wikis = wiki
            guard let kWikis = self.wikis else { return }
            kWikis.query.pages.forEach({ page in
                self.titles.append(page.value.title)
                self.images.append((page.value.thumbnail?.source) ?? "")
                self.desc.append(contentsOf: page.value.terms?["description"] ?? ["No Data"])
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
    
}

extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? CustomCell else {
            assertionFailure("ViewController: Could not dequeue a cell of type Custom Cell.")
            return UITableViewCell()
        }
        cell.accessoryType = .disclosureIndicator
        
        let currentTitle = titles[indexPath.row]
        let currentImageURLString = images[indexPath.row]

        cell.titleLabel.text = currentTitle
        cell.subtitleLabel.text = "Sample"

        if let url = URL(string: currentImageURLString) {
            cell.thumbnailImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "globe"), completionHandler: nil)
        } else {
            //URL couldn't be made for some reason. Resorting to a default placeholder value
            cell.thumbnailImageView.image = UIImage(systemName: "globe")
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        cell?.imageView?.kf.cancelDownloadTask()

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRowDescription = desc[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        controller.placeDescription = selectedRowDescription
        navigationController?.pushViewController(controller, animated: true)
    }
}
