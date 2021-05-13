//
//  ToDoListCell.swift
//  ToDoMotilalAssigment
//
//  Created by Rupali Patil on 12/05/21.
//  Copyright © 2021 63moons. All rights reserved.
//

import UIKit

class ToDoListCell: UITableViewCell {

    @IBOutlet weak var m_cTaskDescription: UILabel!
    @IBOutlet weak var m_cTaskName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
