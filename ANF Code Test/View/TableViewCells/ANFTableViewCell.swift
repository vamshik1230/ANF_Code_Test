//
//  ANFTableViewCell.swift
//  ANF Code Test
//
//  Created by Vamshi on 08/25/22.
//

import UIKit

class ANFTableViewCell: UITableViewCell {

    @IBOutlet private(set) weak var backgroundImageView: UIImageView!
    @IBOutlet private(set) weak var topLabelStackView: UIStackView!
    @IBOutlet private(set) weak var topDescriptionLabel: UILabel!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var promoMessageLabel: UILabel!
    @IBOutlet private(set) weak var bottomDescriptionLabel: UILabel!
    @IBOutlet private(set) weak var contentStackView: UIStackView!
    @IBOutlet private(set) weak var firstButton: UIButton!
    @IBOutlet private(set) weak var secondButton: UIButton!
    
    private var contents: [(title: String, target: String)]?
    
    var shopMenButtoAction: (() -> ())?
    var shopWomenButtonAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstButton.layer.borderColor = UIColor.gray.withAlphaComponent(0.7).cgColor
        secondButton.layer.borderColor = UIColor.gray.withAlphaComponent(0.7).cgColor
        firstButton.layer.borderWidth = 2.0
        secondButton.layer.borderWidth = 2.0
        backgroundImageView.contentMode = .scaleAspectFill
        
        topLabelStackView.setCustomSpacing(22.0, after: promoMessageLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func shopMenAction(_ sender: UIButton) {
        guard let handler = shopMenButtoAction else {
            return
        }
        handler()
    }
    
    @IBAction func shopWomenAction(_ sender: UIButton) {
        guard let handler = shopWomenButtonAction else {
            return
        }
        handler()
    }
    
    func configureUI(_ backgroundImage: String? = nil,
                     topDescription: String? = nil,
                     title: String? = nil,
                     promoMsg: String? = nil,
                     bottomDescription: String? = nil,
                     contents: [(title: String, target: String)]? = nil) {
        
        if let desc = topDescription {
            topDescriptionLabel.text = desc
        } else {
            topDescriptionLabel.text = ""
        }
        
        if let title = title {
            titleLabel.text = title
        }
        
        if let promoMessage = promoMsg {
            promoMessageLabel.text = promoMessage
        } else {
            promoMessageLabel.text = ""
        }
        
        if let _ = bottomDescription {
            bottomDescriptionLabel.text = "In stores & online. Exclusions apply. See Details."
        } else {
            bottomDescriptionLabel.text = ""
        }
        
        firstButton.isHidden = false
        secondButton.isHidden = false
        
        if let contents = contents {
            if contents.count < 1 {
                secondButton.isHidden = true
            } else {
                secondButton.isHidden = false
            }
            for (index, contentElement) in contents.enumerated() {
                if index == 0 {
                    firstButton.setTitle(contentElement.title, for: .normal)
                } else {
                    secondButton.setTitle(contentElement.title, for: UIControl.State.normal)
                }
            }
        } else {
            firstButton.isHidden = true
            secondButton.isHidden = true
        }
    }
    
    func configureImage(_ image: UIImage) {
        backgroundImageView.image = image
    }
}
