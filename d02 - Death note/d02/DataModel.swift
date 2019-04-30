//
//  DataModel.swift
//  d02
//
//  Created by Illia NAZARINA on 4/4/19.
//  Copyright © 2019 Illia NAZARINA. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    var name: String?
    var date: String?
    // add here description
    
    init(name: String?, date: String?) {
        self.name = name;
        self.date = date;
    }
}
