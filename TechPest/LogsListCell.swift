//
//  LogsListCell.swift
//  TechPest
//
//  Created by Monica Barrios on 12/6/22.
//

import UIKit

class LogsListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var PesticideTitleLabel: UILabel!
    
    
    @IBOutlet weak var AreaOfApplicationLabel: UILabel!
    
    
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
