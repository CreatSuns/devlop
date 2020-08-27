//
//  MineViewController.swift
//  SwiftProject
//
//  Created by 李世航 on 2018/7/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit
//import SnapKit

enum Sex {
    case man
    case women
}

struct Person {
    var height = 165.0
    var weight = 50.0
    var sex = Sex.man
    
}

class people: NSObject {
    var header : String?
    var footer : String?
    
}

class MineViewController: UIViewController {

    var ppp = "ssss"
    lazy var sss : String = {
       let add = "aaa"
        return add
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        // Do any additional setup after loading the view.
        createLabel(title: "哈哈")
        createButton("点击")
        
        createBlock { (nnn) in
            //闭包实现
            print("\(nnn)")
        }
        
        var lishihang = Person()
        lishihang.height = 180.0
        lishihang.weight = 50.1
        
        
        print("lishihang height = \(lishihang.height), sex == \(lishihang.sex)")
        
        let lijunheng = people()
        lijunheng.header = "header"
        lijunheng.footer = "footer"
        
        var hei = 100
        age(hei: &hei)
        
        print(Unmanaged<AnyObject>.passUnretained(sss as AnyObject).toOpaque())
        print(Unmanaged<AnyObject>.passUnretained(sss as AnyObject).toOpaque())
        
    }
    
    func createLabel(title:String) -> Void {
        let label = UILabel()
        label.text = title
        label.textColor = UIColor.red
        label.backgroundColor = UIColor.yellow
        self.view.addSubview(label)
        
        label.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.view.snp.left).offset(20)
            make.top.equalTo(self.view.snp.top).offset(20)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    func createButton(_ title :String) -> Void {
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle(title, for: UIControlState.normal)
        button.setTitle("变了", for: UIControlState.highlighted)
        button.setTitleColor(UIColor.red, for: UIControlState.normal)
        button.setTitleColor(UIColor.blue, for: UIControlState.highlighted)
        button.addTarget(self, action: #selector(buttonCilck), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button);
        
        button.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(20)
            make.top.equalTo(self.view.snp.top).offset(80)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
    }
    
    @objc func buttonCilck() {
        
        awa({ (aaa, bbb) -> Int in
            //闭包实现
            return aaa + bbb
        }, 3, 4)
    }
    
    //闭包当做参数
    func awa(_ fuu:(Int, Int) -> Int, _ a : Int, _ b : Int) {
        print("结果： \(fuu(a, b))");
    }
    
    //尾随闭包
    func createBlock(dele:(_ num : String ) -> Void){
        dele("执行dele方法")
    }
    
    
    
    
    func age(hei: inout Int) -> Void {
        hei = 50
        print("hei==\(hei)")
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



