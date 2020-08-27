//
//  CenterViewController.swift
//  SwiftProject
//
//  Created by 李世航 on 2018/7/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CellDelegate {
    
    
    let array = ["aaa","bbb","ccc"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        
        createTable()
        
        // Do any additional setup after loading the view.
    }
    
    private func createTable() {
        let table = UITableView(frame: self.view.bounds, style: UITableViewStyle.grouped)
        table.delegate = self as UITableViewDelegate
        table.dataSource = self as UITableViewDataSource
        self.view.addSubview(table)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        cell.delegate = self
        cell.textLabel?.text = array[indexPath.row]
        return cell
        
    }
    
    
    func abc(string: String) {
        print(string)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
