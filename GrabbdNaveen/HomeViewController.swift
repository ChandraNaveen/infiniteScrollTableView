//
//  HomeViewController.swift
//  GrabbdNaveen
//
//  Created by Naveen Chandra on 10/01/20.
//  Copyright © 2020 Naveen Chandra. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource  = self
        self.view = tableView
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
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
