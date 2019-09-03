//
//  MediaViewModel.swift
//  GeniusPlazaCoding
//
//  Created by Nitin Pabba on 9/3/19.
//  Copyright © 2019 Nitin Pabba. All rights reserved.
//

import Foundation

struct Response: Codable {
    var feed: Feed
}

struct Feed: Codable {
    var results: [Media]
}

struct Media: Codable {
    var name: String
    var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case imageURL = "artworkUrl100"
    }
}

class MediaViewModel {
    typealias NotifyBlock = () -> Void
    var mediaArray: [Media]? {
        didSet {
            notifyWhenDataComplete?()
        }
    }
    var notifyWhenDataComplete: NotifyBlock?
    
    // MARK: - Public
    
    func getMedia() {
        WebService.loadiTunesMedia { (responseArray) in
            self.mediaArray = responseArray
        }
    }
}


