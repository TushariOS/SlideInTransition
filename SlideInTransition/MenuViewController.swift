//
//  MenuViewController.swift
//  SlideInTransition
//
//  Created by Tushar on 25/09/19.
//  Copyright © 2019 Tushar. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case home
    case camera
    case profile
}

class MenuViewController: UITableViewController {

    var didMenuTapped: ((MenuType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else {
            return
        }
        print(menuType)
        
        dismiss(animated: true, completion: { [weak self] in
            self?.didMenuTapped?(menuType)
        })
    }
}
