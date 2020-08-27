//
//  TabbarViewController.swift
//  SwiftProject
//
//  Created by 李世航 on 2018/7/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {
    var array = NSMutableArray();
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSubVC(vc: HomeViewController(), title: "haha")
        createSubVC(vc: CenterViewController(), title: "hehe")
        createSubVC(vc: MineViewController(), title: "heihei")
        self.viewControllers = array as? [UIViewController];
        
        // Do any additional setup after loading the view.
    }
    
    func createSubVC(vc:UIViewController, title:String) -> Void {
        
        let nav = UINavigationController(rootViewController: vc);
        
        nav.tabBarItem.title = title;
        vc.navigationItem.title = title;
        
        nav.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15), NSAttributedStringKey.backgroundColor : UIColor.red], for: UIControlState.highlighted )
        array.add(nav);
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
