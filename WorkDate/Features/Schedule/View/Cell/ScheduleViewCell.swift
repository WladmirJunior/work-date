//
//  ScheduleViewCell.swift
//  WorkDate
//
//  Created by Wladmir  on 10/04/21.
//

import UIKit

class ScheduleViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundContentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var titleJob: UILabel!
    @IBOutlet weak var valueJob: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundContentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowOpacity = 0.24
        contentView.layer.shadowRadius = CGFloat(2)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
