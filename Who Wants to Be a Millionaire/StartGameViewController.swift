//
//  StartGameViewController.swift
//  Who Wants to Be a Millionaire
//
//  Created by Ilya Paddubny on 26.02.2024.
//

import UIKit

class StartGameViewController: UIViewController {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Hello everyone!"
        label.sizeToFit()
        label.center = view.center
        view.addSubview(label)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
