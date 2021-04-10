//
//  ScheduleEntity.swift
//  WorkDate
//
//  Created by Wladmir  on 10/04/21.
//

import Foundation

public class ScheduleEntity: NSCoder, NSCoding {
    public var dateLabel: String
    public var timeLabel: String
    public var clientName: String
    public var titleJob: String
    public var valueJob: String
    
    public override init() {
        self.dateLabel = ""
        self.timeLabel = ""
        self.clientName = ""
        self.titleJob = ""
        self.valueJob = ""
    }
    
    public init(
        dateLabel: String,
        timeLabel: String,
        clientName: String,
        titleJob: String,
        valueJob: String) {
        self.dateLabel = dateLabel
        self.timeLabel = timeLabel
        self.clientName = clientName
        self.titleJob = titleJob
        self.valueJob = valueJob
    }
    
    required convenience public init(coder aDecoder: NSCoder) {
        let dateLabel = aDecoder.decodeObject(forKey: "dateLabel") as! String
        let timeLabel = aDecoder.decodeObject(forKey: "timeLabel") as! String
        let clientName = aDecoder.decodeObject(forKey: "clientName") as! String
        let titleJob = aDecoder.decodeObject(forKey: "titleJob") as! String
        let valueJob = aDecoder.decodeObject(forKey: "valueJob") as! String
        self.init(
            dateLabel: dateLabel,
            timeLabel: timeLabel,
            clientName: clientName,
            titleJob: titleJob,
            valueJob: valueJob)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(dateLabel, forKey: "dateLabel")
        aCoder.encode(timeLabel, forKey: "timeLabel")
        aCoder.encode(clientName, forKey: "clientName")
        aCoder.encode(titleJob, forKey: "titleJob")
        aCoder.encode(valueJob, forKey: "valueJob")
    }
}
