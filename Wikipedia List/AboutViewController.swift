//
//  AboutViewController.swift
//  Wikipedia List
//
//  Created by Kapil on 05/02/21.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    
    var placeDescription = ""
    var aboutLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      //  print("\(placeDescription)")
        aboutLabel.text = placeDescription
        aboutLabel.numberOfLines = 0
        aboutLabel.frame = CGRect(x: 0, y: self.view.center.y, width: self.view.frame.width, height: 0)
        aboutLabel.sizeToFit()
        aboutLabel.textAlignment = .center
        self.view.addSubview(aboutLabel)
    }
    
}
