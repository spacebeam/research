# -*- coding: utf-8 -*-
'''
    Flying Saucer wxWidgets TaskBar.
'''

# This file is part of a flying saucer experience.

# Distributed under the terms of the last Apache License.
# The full license is in the file LICENCE, distributed as part of this software.

__author__ = 'Team Machine'


import wx
import webbrowser
import subprocess
import logging


class CustomTaskBarIcon(wx.TaskBarIcon):
    '''
        Custom TaskBar Icon
    '''
    TBMENU_DISPLAY = wx.NewId()
    TBMENU_APPLICATIONS = wx.NewId()
    TBMENU_APPEARANCE = wx.NewId()
    TBMENU_AUDIO = wx.NewId()
    TBMENU_FILE = wx.NewId()
    TBMENU_WEB = wx.NewId()
    TBMENU_MEDIA = wx.NewId()
    TBMENU_CLOSE = wx.NewId()
    TBMENU_SBIO = wx.NewId()

    def __init__(self, frame):
        wx.TaskBarIcon.__init__(self)
        self.frame = frame
        img = wx.Image("/opt/saucer/24x24.png", wx.BITMAP_TYPE_ANY)
        bmp = wx.BitmapFromImage(img)
        self.icon = wx.EmptyIcon()
        self.icon.CopyFromBitmap(bmp)
        self.SetIcon(self.icon, "Space-based adjutant")
        # bind some events
        self.Bind(wx.EVT_MENU, self.OnTaskBarClose, id=self.TBMENU_CLOSE)
        self.Bind(wx.EVT_MENU, self.OnApplications, id=self.TBMENU_APPLICATIONS)
        self.Bind(wx.EVT_MENU, self.OnAppearance, id=self.TBMENU_APPEARANCE)
        self.Bind(wx.EVT_MENU, self.OnAudioControl, id=self.TBMENU_AUDIO)
        self.Bind(wx.EVT_MENU, self.OnFileControl, id=self.TBMENU_FILE)
        self.Bind(wx.EVT_MENU, self.OnWebBrowser, id=self.TBMENU_WEB)
        self.Bind(wx.EVT_MENU, self.OnMediaPlayer, id=self.TBMENU_MEDIA)
        self.Bind(wx.EVT_MENU, self.OnDisplaySettings, id=self.TBMENU_DISPLAY)
        self.Bind(wx.EVT_MENU, self.OnSpacebeamIO, id=self.TBMENU_SBIO)
        self.Bind(wx.EVT_TASKBAR_LEFT_DOWN, self.OnLeftClickMenu)
        self.Bind(wx.EVT_TASKBAR_RIGHT_DOWN, self.OnRightClickMenu)

    def CreatePopupMenu(self, event=None):
        '''
            This method is called by the base class when it need to popup
            the menu for the default EVT_RIGHT_DOWN event.

            Just create the menu how you want it and return it from this function.
        '''
        menu = wx.Menu()
        menu.Append(self.TBMENU_APPLICATIONS, "Applications")
        menu.AppendSeparator()
        menu.Append(self.TBMENU_FILE, "File Manager")
        menu.Append(self.TBMENU_WEB, "Web Browser")
        menu.Append(self.TBMENU_MEDIA, "Media Player")
        menu.AppendSeparator()
        menu.Append(self.TBMENU_APPEARANCE, "Look and Feel")
        menu.Append(self.TBMENU_DISPLAY, "Display Settings")
        menu.Append(self.TBMENU_AUDIO, "Audio Control")
        menu.AppendSeparator()
        menu.Append(self.TBMENU_CLOSE, "Exit")
        return menu

    def CreateWorkMenu(self, event=None):
        '''
            This method is called by the class when it need to popup
            the menu for the default EVT_LEFT_DOWN event.

            Just create the menu how you want it and return ir from this function.
        '''
        menu = wx.Menu()
        menu.Append(self.TBMENU_SBIO, "Start")
        menu.AppendSeparator()
        menu.Append(self.TBMENU_SBIO, "Options")
        return menu

    def OnSpacebeamIO(self, event):
        '''
            On Spacebeam I/O
        '''
        webbrowser.open_new('https://github.com/spacebeam') 

    def OnAppearance(self, event):
        '''
            On LXEAppearance
        '''
        subprocess.Popen(['lxappearance'])

    def OnTaskBarClose(self, event):
        '''
            Destroy the taskbar icon and frame from the taskbar icon itself
        '''
        self.frame.Close()
        subprocess.Popen(['i3-msg', 'exit'])

    def OnLeftClickMenu(self, event):
        '''
            Create the left-click menu
        '''
        self.frame.Hide()
        menu = self.CreatePopupMenu()
        self.PopupMenu(menu)
        menu.Destroy()
    
    def OnRightClickMenu(self, event):
        '''
            Create the right-click menu
        '''
        self.frame.Hide()
        menu = self.CreateWorkMenu()
        self.PopupMenu(menu)
        menu.Destroy()

    def OnAudioControl(self, event):
        subprocess.Popen(['pavucontrol'])

    def OnFileControl(self, event):
        subprocess.Popen(['pcmanfm'])

    def OnMediaPlayer(self, event):
        subprocess.Popen(['vlc'])

    def OnWebBrowser(self, event):
        subprocess.Popen(['google-chrome'])

    def OnDisplaySettings(self, event):
        subprocess.Popen(['lxrandr'])

    def OnApplications(self, event):
        subprocess.Popen(['pcmanfm', 'menu://applications/'])
