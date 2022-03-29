//
//  movieTBC.swift
//  AlamofireRequest
//
//  Created by Dilara on 14.03.2022.
//

import UIKit

class movieTBC: UITableViewCell {

    @IBOutlet weak var imgviewMovie: UIImageView!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
