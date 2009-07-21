#
#  NamasteDelegate.rb
#  Namaste
#
#  Created by Arun Thampi on 7/21/09.
#  Copyright (c) 2009 Bezurk. All rights reserved.
#

class NamasteDelegate
  attr_accessor :web_view
  attr_accessor :url_field
  attr_accessor :google_search_field
  
  
  def applicationDidFinishLaunching(notification)
    NSLog "Namaste! Going to launch a default website"
    web_view.mainFrame.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString("http://www.wego.com")))
    NSLog "Finished giving instruction to load the page"
  end
end
