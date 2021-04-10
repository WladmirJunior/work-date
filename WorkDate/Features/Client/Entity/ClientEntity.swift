//
//  ClientEntity.swift
//  WorkDate
//
//  Created by Wladmir  on 10/04/21.
//

import Foundation

public class ClientEntity: NSObject, NSCoding {
    public var name: String
    public var address: String
    public var phone: String
    
    public override init() {
        self.name = ""
        self.address = ""
        self.phone = ""
    }
    
    public init(name: String, address: String, phone: String) {
        self.name = name
        self.address = address
        self.phone = phone
    }
    
    required convenience public init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let address = aDecoder.decodeObject(forKey: "address") as! String
        let phone = aDecoder.decodeObject(forKey: "phone") as! String
        self.init(name: name, address: address, phone: phone)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(phone, forKey: "phone")
    }
}
