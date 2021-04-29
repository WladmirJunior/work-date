//
//  AutoSizingTableView.swift
//  WorkDate
//
//  Created by Wladmir on 28/04/21.
//

import UIKit

public class AutoSizingTableView: UITableView {
    override public var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override public func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.setNeedsLayout()
    }

    override public var intrinsicContentSize: CGSize {
        setNeedsLayout()

        return CGSize(width: contentSize.width, height: contentSize.height)
    }
}
