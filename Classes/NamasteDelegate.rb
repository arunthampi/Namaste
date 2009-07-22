#
#  NamasteDelegate.rb
#  Namaste
#
#  Created by Arun Thampi on 7/21/09.
#  Copyright (c) 2009 Bezurk. All rights reserved.
#
require 'uri'

class NamasteDelegate
  attr_accessor :web_view
  attr_accessor :url_field
  attr_accessor :google_search_field
  
  
  def applicationDidFinishLaunching(notification)
    NSLog("Namaste!")
  end
  
  def loadURL(sender)
    url = sender.stringValue
    url = "http://#{url}" if url.index('http:\/\/').nil?
    
    NSLog("Going to log url: #{url}")
    web_view.mainFrame.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString(url)))
  end
  
  def loadGoogleSearchPage(sender)
    search_term = URI.encode(sender.stringValue)
    url = "http://www.google.com/search?rls=en-us&q=#{search_term}&ie=UTF-8&oe=UTF-8"
    web_view.mainFrame.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString(url)))
  end
  
end