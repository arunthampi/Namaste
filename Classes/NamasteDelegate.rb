#
#  NamasteDelegate.rb
#  Namaste
#
#  Created by Arun Thampi on 7/21/09.
#  Copyright (c) 2009. All rights reserved.
#
require 'uri'

class NamasteDelegate
  attr_accessor :web_view
  attr_accessor :url_field
  attr_accessor :google_search_field
  
  def applicationDidFinishLaunching(notification)
    # Set the delegate of the URL Field to be NamasteDelegate,
    # so that we can handle events
    url_field.delegate = self
    google_search_field.delegate = self
    # Introductory log
    NSLog("Namaste!")
  end
  
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