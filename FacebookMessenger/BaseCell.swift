//
//  BaseCell.swift
//  FacebookMessenger
//
//  Created by Ronald Hernandez on 12/30/16.
//  Copyright © 2016 Ronaldoh1. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpViews(){
        //self.backgroundColor = UIColor.yellowColor()
    }
    
}
