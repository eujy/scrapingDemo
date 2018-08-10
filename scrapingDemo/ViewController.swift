//
//  ViewController.swift
//  scrapingDemo
//
//  Created by Riku Uchida on 2018/08/09.
//  Copyright © 2018年 eujy. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class ViewController: UIViewController {
    
    var Honbun = ["test"]
    var count: Int = 0

    @IBOutlet weak var textView: UITextView!
    @IBAction func scrapingButton(_ sender: Any) {
        scrapeWebsite()
        
        print("heyhey")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrapeWebsite() {
        
        //GETリクエスト 指定URLのコードを取得
        Alamofire.request("https://www.yahoo.co.jp").responseString { response in
            print("\(response.result.isSuccess)")
            
            if let html = response.result.value {
                self.parseHTML(html: html)
            }
        }
    }
    
    func parseHTML(html: String) {
        if let doc = try? HTML(html: html, encoding: .utf8) {
            print(doc.title as Any)
            
            for link in doc.css("a, link") {
                print(link.text as Any)
                print(link["href"] as Any)
                Honbun.append(link.text!)
                Honbun.append(link["href"]!)
            }
        }
        let str:String = Honbun.joined()
        textView.text = str
    }


}

