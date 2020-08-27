class Login():
    def __init__(self, client, session):
        self.client = client
        self.session = session
    
    def rootRoute(self):
        status = self.session(type='XCUIElementTypeButton',name='登录').exists
        if status:
            print('登录界面')
            self.login()
        else:
            print('进入首页')
            self.goUserAgentRoute()

    def login(self):
        self.login_username_tf()
        
    def login_area_code(self):
        print('aaa')
        self.session(xpath='XCUIElementTypeStaticText[@name="+86"]').tap()
        # print(s(xpath='XCUIElementTypeStaticText[@name="+86"]'))
        
    def login_username_tf(self):
        print(self.session(value='请输入手机号'))
        self.session(value='请输入手机号').set_text('')
        print(self.session(type='XCUIElementTypeCell').exists)
        tableStatus = self.session(type='XCUIElementTypeCell').exists
        print(tableStatus)
        if tableStatus:
            print('有账号历史记录')
            self.session(type='XCUIElementTypeStaticText',value='17858629460').tap()
            self.login_password_tf()
        else:
            print('没有账号历史记录')
            self.session(value='请输入手机号').set_text('17858629460')
            self.login_password_tf()

    def login_password_tf(self):
        self.session(value='请输入密码').set_text("123456")
        self.login_button_click()

    def login_button_click(self):
        self.session(type='XCUIElementTypeButton',name='登录').tap()
        self.chooseLine()

    def chooseLine(self):
        # s(type='XCUIElementTypeCell',index=1).tap()
        self.session(type='XCUIElementTypeStaticText', name='1707').tap()
        self.chooseButtonClick()

    def chooseButtonClick(self):
        self.session(type='XCUIElementTypeButton', name='icon login').tap()
        # goMineVC(s)
        

    def goUserAgentRoute(self):
        # s(type='XCUIElementTypeButton').tap()
        # s(type='XCUIElementTypeStaticText', name='Sun').tap()
        print('开始检测')
        print(self.session(type='XCUIElementTypeTable').child(className='XCUIElementTypeButton').exists)
        self.session(type='XCUIElementTypeTable').child(className='XCUIElementTypeButton').tap()

    def goMineVC(self):
        self.session(type='XCUIElementTypeButton',name='我的').tap()
        self.goMineSettingVC()  

    def goMineSettingVC(self):
        self.session(type='XCUIElementTypeButton',name='icon setting').tap()
        self.loginOut()

    def loginOut(self):
        self.session(type='XCUIElementTypeButton',name='退出登录').tap()
        self.rootRoute()