//
//  ProfileViewController.swift
//  EndTerm
//
//  Created by Manav Sethi on 2019-12-04.
//  Copyright © 2019 Manav Sethi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var username:String = ""
    var bio:String = ""
    var image: UIImage?

    @IBOutlet weak var Bio: UILabel!
    @IBOutlet weak var DisplayName: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Bio.text = bio
        DisplayName.text = username
        ProfileImage.image = image

       
    }
    

  

}
