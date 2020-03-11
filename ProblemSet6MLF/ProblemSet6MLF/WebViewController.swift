//
//  WebViewController.swift
//  ProblemSet6MLF
//
//  Created by Mateo Larrea Ferro on 3/10/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://audiokit.io/")
        let request = URLRequest(url: url!) //exclamation value
        webView.load(request)
 
    }
}
