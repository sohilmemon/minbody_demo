//
//  CountryTableViewCell.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import UIKit
import SDWebImage

class CountryTableViewCell: UITableViewCell {

    ///Cell Reuse Identifier
    static let identifier = "CountryTableViewCell"
    
    /// Nib File Instantiation
    static func nib() -> UINib {
        return UINib.init(nibName: identifier, bundle: nil)
    }
    
    //MARK: Outlets
    @IBOutlet weak var imageViewCountryFlag: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    /// UI Initialization
    private func setupUI() {
        imageViewCountryFlag.layer.cornerRadius = imageViewCountryFlag.frame.size.width / 2
        imageViewCountryFlag.layer.masksToBounds = true
    }

    /// UI Rendering
    func setupData(_ data: CountryModel) {
        lblCountryName.text = data.name.capitalized
        imageViewCountryFlag.sd_setImage(with: URL(string: Constants.URL.GITHUB_COUNTRY_FLAG_BASE_URL + "\(data.code.lowercased()).png"), placeholderImage: UIImage(named: "placeholder_image"))
    }
    
}
