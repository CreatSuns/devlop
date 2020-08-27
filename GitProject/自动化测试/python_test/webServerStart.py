import unittest
import os
from appium import webdriver
from time import sleep
from appium.webdriver.common.touch_action import TouchAction
from selenium.common.exceptions import NoSuchElementException


class  loginTest (unittest.TestCase):
	def  setUp(self):
		app = os.path.abspath('/Users/Jeffrey/Desktop/CareVoice.app')

		self.driver = webdriver.Remote(
			command_executor = 'http://127.0.0.1:4723/wd/hub',
			desired_capabilities = {
				'app':app,
                'platformName': 'iOS',
                'platformVersion': '11.2',
                'deviceName': 'iPad Air',
                'bundleId': 'co.kangyu.Kangyu',
                'automationName':'XCUITest',
                "noReset": 'true'
				# 'udid': '45751dc8cd8d737bbcea48a0307d50419161afb8'
			}
		)
	def test_login(self):
		print ("启动login测试")
		sleep(1)
		print ("开始测试")
		driver = self.driver

		el1 = driver.find_element_by_accessibility_id("Profile")
		el1.click()
		print ('点击profile')

		el2 = driver.find_element_by_accessibility_id("Sign In")
		el2.click()

		try:
			el3 = driver.find_element_by_xpath("//XCUIElementTypeApplication[@name=\"The CareVoice\"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeScrollView/XCUIElementTypeOther[1]/XCUIElementTypeScrollView")
		except NoSuchElementException:
			print ('已经登录了')
			return;
			# 执行退出登录
			TouchAction(driver).press(x=358, y=779).move_to(x=3, y=-303).release().perform()
			    
			TouchAction(driver).press(x=339, y=787).move_to(x=22, y=-272).release().perform()
			    
			TouchAction(driver).press(x=347, y=818).move_to(x=3, y=-444).release().perform()
			    
			ell1 = driver.find_element_by_accessibility_id("Settings")
			ell1.click()
			print ('点击设置')
			ell2 = driver.find_element_by_accessibility_id("Sign Out")
			ell2.click()
			print ('点击退出登录')

			el3 = driver.find_element_by_xpath("//XCUIElementTypeApplication[@name=\"The CareVoice\"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeScrollView/XCUIElementTypeOther[1]/XCUIElementTypeScrollView")
			el3.click()
		else:
			print ('还没有登录，所以可以找到')
			el3.click()

		print ('点击密码登录')
		el4 = driver.find_element_by_accessibility_id("phone")
		print ('点击用户名')
		el4.send_keys("13262851829")
		print ('输入用户名')

		el5 = driver.find_element_by_xpath("//XCUIElementTypeApplication[@name=\"The CareVoice\"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeScrollView")
		el5.click()
		print ('收起键盘')

		el6 = driver.find_element_by_xpath("//XCUIElementTypeApplication[@name=\"The CareVoice\"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeScrollView/XCUIElementTypeOther[3]/XCUIElementTypeOther[1]/XCUIElementTypeSecureTextField")
		el6.click()

		print ('点击密码')
		el6.send_keys("111111")
		print ('输入密码')

		# el5.click()
		# el7 = driver.find_element_by_accessibility_id("Sign In")
		# el7.click()
		# print ('点击登录')

		el8 = driver.find_element_by_accessibility_id("Return")
		el8.click()
		print ('点击登录')

		sleep(1)

		TouchAction(driver).press(x=394, y=303).move_to(x=-25, y=479).release().perform()

		el8 = driver.find_element_by_accessibility_id("Home")
		print ('点击Home')
		el8.click()

	def tearDown(self):
		sleep(5)
		print ('退出程序')
		self.driver.quit()

if __name__ == '__main__':
	suite = unittest.TestLoader().loadTestsFromTestCase(loginTest)
	unittest.TextTestRunner(verbosity=2).run(suite)