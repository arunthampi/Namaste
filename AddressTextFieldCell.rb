#
#  AddressTextFieldCell.rb
#  Namaste
#
#  Created by Arun Thampi on 7/28/09.
#  Copyright (c) 2009 Bezurk. All rights reserved.
#

class AddressTextFieldCell < NSTextFieldCell
  X_AXIS_PADDING_LEFT = 16
  Y_AXIS_PADDING = 3
  HEIGHT = 22
  X_AXIS_PADDING_RIGHT = 20
  
  def init
    super
  end
  
  def drawInteriorWithFrame(bounds, inView:cellFrame)
    super(getNewTitleRectBoundsFrom(bounds), cellFrame)
  end
  
  def editWithFrame(bounds, inView: controlView, editor: textObj, delegate: anObject, start: selStart, length: selLength)
    super(getNewTitleRectBoundsFrom(bounds), controlView, textObj, anObject, selStart, selLength)
  end
  
  
  def selectWithFrame(bounds, inView: controlView, editor: textObj, delegate: anObject, start: selStart, length: selLength)
    super(getNewTitleRectBoundsFrom(bounds), controlView, textObj, anObject, selStart, selLength)
  end
  
  def getNewTitleRectBoundsFrom(bounds)
    titleRect = self.titleRectForBounds(bounds)
    titleRect.origin.x = titleRect.origin.x + X_AXIS_PADDING_LEFT
    titleRect.origin.y = titleRect.origin.y - Y_AXIS_PADDING
    
    titleRect.size.height = HEIGHT
    titleRect.size.width = titleRect.size.width - X_AXIS_PADDING_RIGHT
  
    titleRect
  end
  
end
