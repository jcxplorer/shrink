class Group
  attr_accessor :document, :name, :text, :display
  
  def initialize(document={})
    self.document = document
    self.name     = document["name"]
    self.display  = document["display"] || "list"
    self.text     = document["text"]
  end

  def attributes
    if self.document && self.document["attributes"]
      self.document["attributes"].map { |attribute| Attribute.new(attribute) }
    else
      []
    end
  end
end
