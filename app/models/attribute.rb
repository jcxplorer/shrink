class Attribute
  attr_accessor :key, :value

  def initialize(document={})
    self.key    = document["key"]
    self.value  = document["value"]
  end
end
