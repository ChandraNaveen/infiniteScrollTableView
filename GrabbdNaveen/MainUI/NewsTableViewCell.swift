//
//  NewsTableViewCell.swift
//  GrabbdNaveen
//
//  Created by Naveen Chandra on 10/01/20.
//  Copyright © 2020 Naveen Chandra. All rights reserved.

//

import UIKit
import Cartography

class NewsTableViewCell: UITableViewCell {
    
    let itemImageView = UIImageView()
    let titleLabel = UILabel()
    let sourceLabel = UILabel()
    let descriptionLabel = UILabel()
    let dateLabel = UILabel()
    let authorLabel = UILabel()
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        // code to make full bottom border
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.selectionStyle = .none
        //code to make full bottom border
        
        
        
        itemImageView.layer.cornerRadius = 8.0
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.image = UIImage(named: "defaultRestaurantImage")
        
        titleLabel.textColor = UIColor.black
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = false
        
        
        authorLabel.textColor = UIColor.black
        authorLabel.sizeToFit()
        authorLabel.textAlignment = .left
        authorLabel.numberOfLines = 1
        authorLabel.adjustsFontSizeToFitWidth = false
        
        
        
        
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        
        descriptionLabel.sizeToFit()
        descriptionLabel.textAlignment = .left
        
        
        
        
        dateLabel.adjustsFontSizeToFitWidth = false
        dateLabel.textColor = UIColor.red
        
        sourceLabel.adjustsFontSizeToFitWidth = false
        sourceLabel.textColor = UIColor.red
        
        
        
        contentView.addSubview(itemImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(sourceLabel)
        
        constrain([itemImageView,titleLabel,descriptionLabel,dateLabel,authorLabel,sourceLabel]){ (layoutProxies) -> () in
            
            let imgView = layoutProxies[0]
            let name = layoutProxies[1]
            let description = layoutProxies[2]
            let date = layoutProxies[3]
            let author = layoutProxies[4]
            let source = layoutProxies[5]
            
            
            
            let userInterface = UIDevice.current.userInterfaceIdiom
            
            if(userInterface == .pad)
            {
                //iPads
                imgView.width == (imgView.superview!.width) * 0.15
            }
            else if(userInterface == .phone)
            {
                //iPhone
                imgView.width == (imgView.superview!.width) * 0.25
            }
            
            imgView.height == imgView.width
            imgView.left == imgView.superview!.left + 5
            imgView.top == imgView.superview!.top + 10
            
            name.top == name.superview!.top + 5
            name.left == imgView.right + 5
            name.right == name.superview!.right - 5
            name.height == 50
            
            source.left == imgView.right + 5
            source.centerY == imgView.centerY + 5
            source.right == source.superview!.centerX
            source.height == 20
            
            date.left == source.superview!.centerX + 2
            date.centerY == imgView.centerY + 5
            date.right == date.superview!.right
            date.height == 20
            
            
            
            author.left == imgView.right + 5
            author.bottom == imgView.bottom
          
            
            description.right == description.superview!.right - 5
            description.left == description.superview!.left + 5
            description.top == imgView.bottom + 10
            description.bottom == description.superview!.bottom - 10
        }
    }
    
    override func prepareForReuse()
    {
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


