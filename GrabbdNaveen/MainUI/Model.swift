//
//  Model.swift
//  GrabbdNaveen
//
//  Created by Naveen Chandra on 10/01/20.
//  Copyright © 2020 Naveen Chandra. All rights reserved.
//

import UIKit

struct DataModel {
    
    var title: String?
    var author: String?
    var date: String?
    var imgURL: String?
    var source: String?
    var desc: String?
    
    
    init(title: String?, author: String?,date: String?, imgURL: String?,source: String?, desc: String?) {
        self.title = title
        self.author = author
        self.date = date
        self.imgURL = imgURL
        self.source = source
        self.desc = desc
    }
}
