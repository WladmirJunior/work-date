//
//  JobEntity.swift
//  WorkDate
//
//  Created by Wladmir  on 10/04/21.
//

import Foundation

public class JobEntity: NSObject, NSCoding {
    public var title: String
    public var value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
    
    override init() {
        self.title = ""
        self.value = ""
    }
    
    required convenience public init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let value = aDecoder.decodeObject(forKey: "value") as! String
        self.init(title: title, value: value)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(value, forKey: "value")
    }
}
