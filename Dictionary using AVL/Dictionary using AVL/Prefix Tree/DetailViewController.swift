//
//  DetailViewController.swift
//  Prefix Tree
//
//  Created by Dai Long on 3/25/18.
//  Copyright © 2018 Dai Long. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailLabel: UILabel!
   // @IBOutlet weak var nameLabel: UILabel!
    
    var detailString: String? = ""
    var nameString: String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: detailLabel.bottomAnchor).isActive = true
        
        
        detailLabel.numberOfLines = 0
        detailLabel.text = detailString ?? ""
        
        navigationItem.title = detailString ?? ""
    }
    override func viewDidLayoutSubviews() {
        detailLabel.sizeToFit()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
