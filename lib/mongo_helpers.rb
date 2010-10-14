require "yaml"

module Mongo
  def self.db
    @db ||= begin
      configuration = YAML::load(File.read(Rails.root.join("config/mongodb.yml")))
      environment   = configuration[Rails.env]
      Connection.new.db(environment["database"])
    end
  end
end
