//
//  NewsTableViewCell.swift
//  GrabbdNaveen
//
//  Created by Naveen Chandra on 10/01/20.
//  Copyright © 2020 Naveen Chandra. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    let newsImageView = UIImageView()
    let titleLabel = UILabel()
    let authorLabel  = UILabel()
    let dateLabel = UILabel()
    let sourceLabel = UILabel()
    let descriptionLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        newsImageView.layer.cornerRadius = 10.0
        newsImageView.clipsToBounds = true
        newsImageView.contentMode = .scaleAspectFill
        
        titleLabel.textColor = UIColor.black
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.textColor = UIColor.black
        
        sourceLabel.textColor = UIColor.black
        sourceLabel.adjustsFontSizeToFitWidth = false
        sourceLabel.textColor = UIColor.black
        
        authorLabel.textColor = UIColor.black
        authorLabel.adjustsFontSizeToFitWidth = false
        authorLabel.textColor = UIColor.black
        
        
        
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 2
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.adjustsFontSizeToFitWidth = false
        
        dateLabel.textColor = UIColor.black
        dateLabel.adjustsFontSizeToFitWidth  = true
        
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(authorLabel)
        
        constrain([newsImageView,titleLabel,descriptionLabel,sourceLabel,dateLabel,authorLabel]) { (layoutProxies) -> () in
            
            let imgView = layoutProxies[0]
            let title = layoutProxies[1]
            let descriptionlabel = layoutProxies[2]
            let source = layoutProxies[3]
            let date = layoutProxies[4]
            let author = layoutProxies[5]
            
            imgView.left == (imgView.superview?.left)! + 10
            imgView.top == (imgView.superview?.top)! + 10
            imgView.width   == 80
            imgView.height  == 80
            align(top: imgView ,title)
            
            title.left == imgView.right + 10
            title.right == title.superview!.right - 40
            
            date.centerY == title.centerY
            date.right == date.superview!.right - 5
            date.left == date.superview!.right - 50
            date.height == namelabel.height
                       
            author.left == imgView.right + 10
            author.right == author.superview!.right
            author.top == title.bottom + 5
            
            descriptionlabel.top == author.bottom + 5
            descriptionlabel.left == description.superView.left + 10
            descriptionlabel.right == description.superView.right
            
        
            
            
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
