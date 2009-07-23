#
#  NamasteDelegate.rb
#  Namaste
#
#  Created by Arun Thampi on 7/21/09.
#  Copyright (c) 2009. All rights reserved.
#
require 'uri'

class NamasteDelegate
  # Outlet for the web view which actually uses WebKit
  attr_accessor :web_view
  # Outlet for the address bar
  attr_accessor :url_field
  # Outlet for the Google Search Box
  attr_accessor :google_search_field
  
  def applicationDidFinishLaunching(notification)
    # Set the delegate of the URL Field to be NamasteDelegate,
    # so that we can handle events
    url_field.delegate = self
    google_search_field.delegate = self
    # Introductory log, Namaste to you too
    NSLog("Namaste!")
  end
  
  # This is a delegate method which whenever Cocoa thinks that text editing has finished.
  # Text Editing is deemed finished when either the return key is pressed, or the tab key 
  # is pressed, or could be because some other event.
  #
  # The challenge here is to make sure that:
  #   1. we only respond to return key events
  #   2. we distinguish between the two senders, i.e.
  #       the url_field and the google_search_field
  #
  # 1. is achieved by looking at the key NSTextMovement in the userInfo dictionary which
  # is present in notification object and only checking to if it is NSReturnTextMovement
  # 
  # 2. is achieved by looking at notification.object and checking if it is either == 
  # url_field or google_search_field and only then responding to events.
  def controlTextDidEndEditing(notification)
    if(notification.userInfo['NSTextMovement'] == NSReturnTextMovement)
      if notification.object == url_field
        url = url_field.stringValue
        unless url.nil? || url.length == 0
          url = "http://#{url}" if url.index('http:\/\/').nil?
        end
      elsif notification.object == google_search_field
        search_term  = google_search_field.stringValue
        unless search_term.nil? || search_term.length == 0
          url = "http://www.google.com/search?rls=en-us&q=#{URI.encode(search_term)}&ie=UTF-8&oe=UTF-8"
        end
      end
      
      if url # Only if the URL is set, do soemthing, otherwise sit still.
        NSLog "Fetching the URL: #{url}"
        web_view.mainFrame.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString(url)))
      end
    end
  end
  
end