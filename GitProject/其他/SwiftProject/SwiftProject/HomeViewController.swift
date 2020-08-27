//
//  HomeViewController.swift
//  SwiftProject
//
//  Created by 李世航 on 2018/7/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController,UITextFieldDelegate {
    var textField = UITextField(frame: CGRect(x:0, y:200, width:150, height:30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
       
//        creatLabel(title: "这是一个label")
//        createButton(title: "这是一个button")
//        createTextField(placehold: "这是一个textField")
//        createWebView(url: "http://192.168.20.71:8082/index.html")
        
        let vv = WYAWebView()
        vv.frame = self.view.bounds
        vv.actionName = "networkTest"
        vv.configWebView()
        vv.loadUrl(url: "http://192.168.22.161:8082/index.html")
//        vv.loadLocalHtml(htmlName: "index")
//        vv.loadLocalJS(jsName: "bridge")
        self.view.addSubview(vv)
        vv.vc = self
        
    }

    private func creatLabel(title:String) -> Void {
        let label = UILabel(frame: CGRect(x:0, y:100, width:150, height:30))
        label.text = title
        label.textColor = UIColor.red
        self.view.addSubview(label);
    }
    
    private func createButton(title:String) -> Void {
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle(title, for: UIControlState.normal)
        button.setTitle("变了", for: UIControlState.highlighted)
        button.setTitleColor(UIColor.red, for: UIControlState.normal)
        button.setTitleColor(UIColor.blue, for: UIControlState.highlighted)
        button.frame = CGRect(x: 0, y: 150, width: 150, height: 30)
        button.addTarget(self, action: #selector(buttonCilck), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button);
    }
    
    @objc func buttonCilck() -> Void {
        print("点击")
    }
    
    private func createTextField(placehold:String) -> Void {
        textField.placeholder = placehold
        textField.delegate = self as UITextFieldDelegate
        self.view.addSubview(textField)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField){
        print("开始编辑")
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
