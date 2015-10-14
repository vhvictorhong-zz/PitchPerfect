//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Victor Hong on 2015-09-22.
//  Copyright © 2015 Victor Hong. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL
    var title: String
    
    init (filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}