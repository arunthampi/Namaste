#
#  NamasteDocument.rb
#  Namaste
#
#  Created by Arun Thampi on 7/25/09.
#  Copyright (c) 2009 Bezurk. All rights reserved.
#
class NamasteDocument < NSDocument

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
