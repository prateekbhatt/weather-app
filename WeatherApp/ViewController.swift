//
//  ViewController.swift
//  WeatherApp
//
//  Created by Prateek Bhatt on 15/01/15.
//  Copyright (c) 2015 Prateek Bhatt. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var message: UILabel!
    
    @IBAction func findWeatherButton(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        var urlString = "http://weather-forecast.com/locations/" + city.text.stringByReplacingOccurrencesOfString(" ", withString: "") + "/forecasts/latest"
        var url = NSURL(string: urlString)
        
        println(urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){(data, response, error) in
            
            var webpageContent = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            let tempwebpageContent: String = webpageContent as String
            
            println(tempwebpageContent)
            if (tempwebpageContent.rangeOfString("<span class=\"phrase\">") != nil) {
                
                var contentArray = webpageContent?.componentsSeparatedByString("<span class=\"phrase\">")
            
                var messageText: AnyObject? = contentArray?[1].componentsSeparatedByString("</span>")[0] as String
                println(messageText)
            
                self.message.text = messageText?.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                
            } else {
                
                self.message.text = "Couldn't find that city - please try again"
            }
        }
        
        task.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.message.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

