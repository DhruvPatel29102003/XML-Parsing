//
//  MyViewController.swift
//  xmlfile
//
//  Created by Droadmin on 6/20/23.
//

import UIKit

class MyViewController: UIViewController {
    var titleText: String = ""
    var summaryText: String = ""
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl1.text = titleText
        lbl2.text = summaryText

        // Do any additional setup after loading the view.
    }
    

   

}
