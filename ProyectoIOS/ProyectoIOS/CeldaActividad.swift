//
//  CeldaActividad.swift
//  ProyectoIOS
//
//  Created by dam on 31/1/17.
//  Copyright © 2017 dam. All rights reserved.
//

import UIKit

class CeldaActividad: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var EtiquetaNombre: UILabel!
    @IBOutlet weak var EtiquetaDescripcionCorta: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
