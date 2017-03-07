//
//  ActividadTableViewCell.swift
//  ProyectoIOS
//
//  Created by dam on 31/1/17.
//  Copyright © 2017 dam. All rights reserved.
//

import UIKit
import os.log


class ActividadTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var NombreActividad: UILabel!
    @IBOutlet weak var DescripcionCortaActividad: UITextField!
    @IBOutlet weak var NombreProfesor: UITextField!
    @IBOutlet weak var FechaActividad: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        //DescripcionCortaActividad.deleteBackward()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
