//
//  WebService.swift
//  GeniusPlazaCoding
//
//  Created by Nitin Pabba on 9/3/19.
//  Copyright © 2019 Nitin Pabba. All rights reserved.
//

import Foundation

class WebService {
    
    static func loadiTunesMedia() {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json"
        let url = URL(string: urlString)
        
        guard let guardedUrl = url else {
            return
        }
        
        URLSession.shared.dataTask(with: guardedUrl) { (data, response, error) in
            if let data = data, error == nil {
                print(String(data: data, encoding: .utf8)!)
            } else {
            }
        }.resume()
    }
}
