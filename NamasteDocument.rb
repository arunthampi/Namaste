#
#  MyDocument.rb
#  Namaste
#
#  Created by Greg Borenstein on 6/2/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

class NamasteDocument < NSDocument
  # Outlet for the web view which actually uses WebKit
  attr_accessor :web_view
  # Outlet for the address bar
  attr_accessor :url_field
  # Outlet for the Google Search Box
  attr_accessor :google_search_field
  # Outlet for the go back and go forward buttons
  attr_accessor :go_back_button, :go_forward_button
  # Outlet for Load Status
  attr_accessor :load_status_label, :load_status_spinner
  # User Agent Constant
  USER_AGENT = "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us)" + 
                " AppleWebKit/530.19.2" +
                " (KHTML, like Gecko) Version/4.0.2 Safari/530.19"

  def windowControllerDidLoadNib(windowController)
    super(windowController)
        # Set the delegate of the URL Field to be NamasteDelegate,
    # so that we can handle events
    url_field.delegate = self
    google_search_field.delegate = self
    # Set the webviews delegate to also be NamasteDelegate
    web_view.frameLoadDelegate = self
    web_view.customUserAgent = USER_AGENT

    NSLog("Namaste!")
  end
  
  # This is a delegate method which is called whenever Cocoa thinks that text editing
  # has finished. Text Editing is deemed finished when either the return key is pressed,
  # or the tab key is pressed, or could be because some other event.
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
          url = "http://#{url}" if url.index('http://').nil?
        end
      elsif notification.object == google_search_field
        search_term  = google_search_field.stringValue
        unless search_term.nil? || search_term.length == 0
          url = "http://www.google.com/search?rls=en-us&q=#{URI.encode(search_term)}&ie=UTF-8&oe=UTF-8"
        end
      end
      
      if url # Only if the URL is set, do soemthing, otherwise sit still.
        NSLog "Fetching the URL: #{url}"
        load_status_label.stringValue = "Loading Web Page"
        load_status_label.hidden = false
        
        load_status_spinner.startAnimation(self)
        load_status_spinner.hidden = false
        web_view.mainFrame.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString(url)))
      end
    end
  end
  
  # Delegate method which displays the current URL
  def webView(sender, didStartProvisionalLoadForFrame:frame)
    if frame == sender.mainFrame
      url = frame.provisionalDataSource.request.URL.absoluteString
      NSLog "URL Received from delegate method: #{url}"
      url_field.stringValue = url
    end
  end
  
  # Delegate method which displays the title tag of the page as the title of the window
  def webView(sender, didReceiveTitle:title, forFrame:frame)
    if frame == sender.mainFrame
      sender.window.title = title
      NSLog "Received title for page: #{title}"
    end
  end
  
  # Delegate method which displays the URL in the address field after the page has
  # finally loaded
  def webView(sender, didFinishLoadForFrame:frame)
    if frame == sender.mainFrame
      url = frame.dataSource.request.URL.absoluteString
      NSLog "URL Received from the final loading of the frame: #{url}"
      url_field.stringValue = url
      # Maintain state for back and forward buttons
      NSLog "Can go Back: #{sender.canGoBack} Can Go Forward: #{sender.canGoForward}"
      go_back_button.enabled = (sender.canGoBack == 0) ? false : true
      go_forward_button.enabled = (sender.canGoForward == 0) ? false : true
      NSLog "Going to set loading page"
      load_status_label.stringValue = "Done"
      load_status_spinner.hidden = true
      load_status_spinner.stopAnimation(self)
    end
  end
  
  # Action which handles the back button
  def goBack(sender)
    web_view.goBack
  end
  
  # Action which handles the forward button
  def goForward(sender)
    web_view.goForward
  end
  
  def windowNibName
    # Implement this to return a nib to load OR implement
    # -makeWindowControllers to manually create your controllers.
    return "NamasteDocument"
  end

  def dataRepresentationOfType(type)
    # Implement to provide a persistent data representation of your
    # document OR remove this and implement the file-wrapper or file
    # path based save methods.
    return nil
  end

  def loadDataRepresentation_ofType(data, type)
    # Implement to load a persistent data representation of your
    # document OR remove this and implement the file-wrapper or file
    # path based load methods.
    return true
  end

end
