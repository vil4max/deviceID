//
//  ViewController.swift
//  DeviceIDGenerator
//
//  Created by Max on 21.12.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var idLabel: UILabel!

    private let idProvider: DeviceTokenProvider = Impl.DeviceTokenProvider(idProvider: .init(),
                                                                           deviceTokenGenerator: .init())
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        idLabel.text = idProvider.token
    }
}
