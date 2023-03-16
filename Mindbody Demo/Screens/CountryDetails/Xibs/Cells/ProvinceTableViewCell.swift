//
//  ProvinceTableViewCell.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import UIKit

class ProvinceTableViewCell: UITableViewCell {

    //MARK: Properties
    ///Cell Reuse Identifier
    static let identifier = "ProvinceTableViewCell"
    
    //MARK: Outlets
    @IBOutlet weak var lblProvinceName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Cell Selection Handling
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
    
    /// UI Rendering
    func setupData(_ data: ProvinceModel) {
        lblProvinceName.text = data.name
    }
    
}
