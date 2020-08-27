
import wda
import unittest
import os
from random import randint
from appium import webdriver
from time import sleep
from login import Login

desired_caps={
                'app': '/Users/lishihang/Library/Developer/Xcode/DerivedData/WYAMaterial-ewpanrxmxhlepfepciwjfoznkarp/Build/Products/Debug-iphonesimulator/WYAMaterial.app',
                'platformName': 'iOS',
                'deviceName': 'iPhone',
                'platformVersion': '12.4',
                'bundleId': 'com.weiyian.material',
                'udid':'2265070b74f839dbed166eb0f9faa64749dd6120',
                # 'udid': 'B91BF532-2535-4DF6-A003-9AAD6104E6BA',
                # 'noReset': true,
}

def configSession():
    wda.DEBUG = False
    wda.HTTP_TIMEOUT = 60
    clint = wda.Client('http://localhost:8100')
    # session = clint.session('com.weiyian.material')
    clint.status
    clint.source(accessible=True)
    s = clint.session(bundle_id='com.weiyian.material')
    print(clint.status)
    print(clint.source(accessible=True))
    # rootRoute(s)
    ll = Login(clint, s)
    ll.rootRoute()




configSession()