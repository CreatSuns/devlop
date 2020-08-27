//
//  WYAWebView.swift
//  SwiftProject
//
//  Created by 李世航 on 2018/8/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit
import WebKit
import CoreTelephony

class WYAWebView: UIView,WKScriptMessageHandler,WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate {
    
    var webView : WKWebView?
    var userContentControll = WKUserContentController()
    let config = WKWebViewConfiguration()
    var vc : UIViewController?
    
    //MARK: 自定义下拉刷新控件（听说mj可以使用）
    var refresh = UIRefreshControl()
    var refreshView : RefreshView = {
        let refresh = RefreshView()
        return refresh
    }()
    var flag = Bool()
    
    //MARK: 进度条
    var progressView : UIProgressView = {
        let progress = UIProgressView()
        progress.trackTintColor = UIColor(red: 240.0/255, green: 240.0/255, blue: 240.0/255, alpha: 1.0)
        progress.progressTintColor = .blue
        return progress
    }()
    
    /// 如果需要和web交互，先注册名字（先执行）
    open var actionName : String?{
        didSet{
            userContentControll.add(self as WKScriptMessageHandler, name: actionName!)
        }
    }
    
    /// 配置webview（先执行）
    func configWebView() -> Void {
        
        let jsString = Bundle.main.path(forResource: "bridge", ofType: "js")
        var jsPath = String()
        do{
            jsPath = try String(contentsOfFile: jsString!)
        }
        catch{
            print(error);
        }

        let userScript = WKUserScript(source: jsPath, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
        userContentControll.addUserScript(userScript)
        
        config.userContentController = userContentControll
        self.webView = WKWebView(frame: self.bounds, configuration: config)
        self.webView!.uiDelegate = self as WKUIDelegate
        self.webView!.navigationDelegate = self as WKNavigationDelegate
        self.webView!.scrollView.delegate = self as UIScrollViewDelegate
        self.webView!.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        self.webView!.sizeToFit()
        self.webView!.scrollView.showsVerticalScrollIndicator = false
        self.webView!.scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(self.webView!)
        
//        self.refresh.tintColor = .red
//        let str = NSAttributedString(string: "下拉刷新")
//        self.refresh.attributedTitle = str
//        self.refresh.addTarget(self, action: #selector(refreshStart), for: .valueChanged)
//        if #available(iOS 10.0, *) {
//            self.webView!.scrollView.refreshControl = self.refresh
//        } else {
//            // Fallback on earlier versions
//        }

//        self.refreshView.frame = CGRect(x: 0, y: -40, width: self.frame.size.width, height: 40)
//        self.webView!.scrollView.addSubview(self.refreshView)
        
        self.progressView.frame = CGRect(x: 0, y: 64, width: self.frame.size.width, height: 1)
        self.addSubview(self.progressView)
        
        self.webView!.scrollView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
    }
    
    @objc func headerRefresh() {
        print("刷新")
        self.webView?.reload()
        self.webView?.scrollView.mj_header.endRefreshing()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
//        self.webView!.snp.makeConstraints { (make) in
//            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
//        }
//
    }
    
    //MARK: 加载url
    func loadUrl(url:String) -> Void {
        let ul = URL(string: url)
        let request = URLRequest.init(url: ul!)
        self.webView!.load(request)
    }
    
    //MARK: 加载本地HTML
    public func loadLocalHtml(htmlName:String) -> Void {
        let string = Bundle.main.path(forResource: htmlName, ofType: "html")
        var path = String()
        do{
            path = try String(contentsOfFile: string!)
        }
        catch{
            print(error)
        }
        self.webView!.loadHTMLString(path, baseURL: Bundle.main.bundleURL)
    }
    
    //MARK: 加载本地JS文件
    public func loadLocalJS(jsName:String) -> Void {
        let jsString = Bundle.main.path(forResource: jsName, ofType: "js")
        var jsPath = String()
        do{
            jsPath = try String(contentsOfFile: jsString!)
        }
        catch{
            print(error);
        }
        self.webView!.evaluateJavaScript(jsPath) { (any, error) in
            print(any ?? 0)
            print(error ?? 1)
        }
        
    }
    //MARK: WKScriptMessageHandler 回调方法
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name)
        print(message.body)
        let string = recognizeNetWork();
        print(string)
        
        let alert  = UIAlertController(title: string, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "确定", style: .default) { (ok) in
            
        }
        alert.addAction(ok)
        
        self.vc!.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: WKUIDelegate
    /*
     public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
     //ios8
     }
     */
    public func webViewDidClose(_ webView: WKWebView) {
        //ios9
        //窗口关闭时调用
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Swift.Void) {
        //ios8
        //在JS端调用alert函数时，会触发此代理方法。JS端调用alert时所传的数据可以通过message拿到。在原生得到结果后，需要回调JS，是通过completionHandler回调
        completionHandler()
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Swift.Void) {
        //js调用原生的方法
        //ios8
        //JS端调用confirm函数时，会触发此方法，通过message可以拿到JS端所传的数据，在iOS端显示原生alert得到YES/NO后，通过completionHandler回调给JS端
        //addScriptMessageHandler 是注册JS的MessageHandler，但是WKWebView在多次调用loadRequest，会出现JS无法调用iOS端。我们需要在loadRequest和reloadWebView的时候需要重新注入。（在注入之前需要移除再注入，避免造成内存泄漏）
        //如果message.body中没有参数，JS代码中需要传null防止iOS端不会接收到JS的交互
        //window.webkit.messageHandlers.<事件名>.postMessage(需要传递的数据)
        
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Swift.Void) {
        //ios8
        //JS端调用prompt函数时，会触发此方法,要求输入一段文本,在原生输入得到文本内容后，通过completionHandler回调给JS
    }
    /*
     public func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
     //ios10
     }
     
     public func webView(_ webView: WKWebView, previewingViewControllerForElement elementInfo: WKPreviewElementInfo, defaultActions previewActions: [WKPreviewActionItem]) -> UIViewController? {
     //ios10
     }
     
     public func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) {
     //ios10
     }
     */
    
    
    //MARK: WKNavigationDelegate
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        //ios8
        //判断链接是否允许跳转
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void) {
        //ios8
        //拿到响应后决定是否允许跳转
        decisionHandler(WKNavigationResponsePolicy.allow)
    }
    
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //ios8
        //链接开始加载时调用
        self.progressView.isHidden = false
    }
    
    
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        //ios8
        //收到服务器重定向时调用
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        //ios8
        //加载错误时调用
        print("加载失败"+error.localizedDescription)
    }
    
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //ios8
        //当内容开始到达主帧时被调用（即将完成）
    }
    
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //ios8
        //加载完成
        print(webView.scrollView.contentSize.height)
        webView.evaluateJavaScript("document.body.scrollHeight") { (result, error) in
            if error == nil {
                var newFrame = webView.frame
                newFrame.size.height = result as! CGFloat
                webView.frame = newFrame
                webView.scrollView.scrollsToTop = true
            }
        }
        
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //ios8
        //在提交的主帧中发生错误时调用
        print("主帧错误"+error.localizedDescription)
    }
    
    
    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        //ios8
        //当webView需要响应身份验证时调用(如需验证服务器证书)
    }
    
    
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        //ios9
        //当webView的web内容进程被终止时调用。(iOS 9.0之后)
        print("终止")
    }
    
    //MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.y)
        var refreshFlag = false
        
        if scrollView.contentOffset.y < -150 {
            
            if refreshFlag == false && self.flag == true {
                print("执行刷新事件")
                refreshFlag = true
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.progressView.alpha = 1
            let animated = (self.webView?.estimatedProgress)! > Double(self.progressView.progress)
            self.progressView.setProgress(Float((self.webView?.estimatedProgress)!), animated: animated)
            if self.webView!.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0.0
                }) { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                }
            }
        }else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    //MARK: 识别网络
    func recognizeNetWork() -> String {
        var string = String()
        
        let reach = Reachability.init(hostName: "www.apple.com")
        let status = reach?.currentReachabilityStatus()
        switch status {
        case ReachableViaWiFi:
            string = "WIFI"
            break;
        case ReachableViaWWAN:
            string = netType()
            
            break;
        case NotReachable:
            string = "NOT"
            break;
        default:
            break;
        }
        return string
    }
    
    //MARK: 识别数据网络类型
    func netType() -> String {
        let ct = CTTelephonyNetworkInfo()
        let aa = ct.currentRadioAccessTechnology
        var string = ""
        if aa == "CTRadioAccessTechnologyGPRS" {
            string = "GPRS"
        }else if aa == "CTRadioAccessTechnologyEdge" {
            string = "2.75G EDGE"
        }else if aa == "CTRadioAccessTechnologyWCDMA" {
            string = "3G"
        }else if aa == "CTRadioAccessTechnologyHSDPA" {
            string = "3.5G HSDPA"
        }else if aa == "CTRadioAccessTechnologyHSUPA" {
            string = "3.5G HSDPA"
        }else if aa == "CTRadioAccessTechnologyCDMA1x" {
            string = "2G"
        }else if aa == "CTRadioAccessTechnologyCDMAEVDORev0" {
            string = "3G"
        }else if aa == "CTRadioAccessTechnologyCDMAEVDORevB" {
            string = "3G"
        }else if aa == "CTRadioAccessTechnologyeHRPD" {
            string = "HRPD"
        }else if aa == "CTRadioAccessTechnologyLTE" {
            string = "4G"
        }
        return string
        
    }
    
    @objc func refreshStart() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
