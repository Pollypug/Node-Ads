//
//  PDFReviewViewController.swift
//  NodeAds
//
//  Created by Polina on 8/14/18.
//  Copyright © 2018 Polina. All rights reserved.
//

import UIKit

class PDFReviewViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var link: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let link = self.link {
        let url: URL! = URL(string: link)
        webView.loadRequest(URLRequest(url: url))
    }
    }

}
