//
//  RecordedAudio.swift
//  pitch-perfect
//
//  Created by Raul Cajias on 04/06/15.
//  Copyright (c) 2015 PilotRex. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL!, title: String!) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}