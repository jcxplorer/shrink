# A +Notification+ is what we get through the API and store.
#
# This class is not supposed to be instantiated by hand. Instead, notifications
# are stored directly with Notification.save.
class Notification
  extend ActiveModel::Naming
  attr_accessor :document, :id, :occurrences, :title

  def initialize(document={})
    self.document     = document
    self.id           = document["id"]
    self.occurrences  = document["occurrences"]
    self.title        = document["title"]
  end

  def to_param
    self.id
  end

  # Fetches all matching notifications from MongoDB.
  #
  # To keep things simple, we just build on top of +Mongo::Collection.find+.
  #
  # If no selector is passed, it will return all notifications.
  #
  # Parameters:
  # * +project_token+
  # * +selector+ (optional): MongoDB selector, passed to +Mongo::Collection.find+
  # * +opts+: Options passed to +Mongo::Collection.find+
  def self.find(project_token, selector={}, opts={})
    cursor = Mongo.db[project_token].find(selector, opts)
    cursor.map { |document| self.new(document) }
  end

  # Saves the notification in MongoDB.
  #
  # Notifications with the same +id+ are only stored once, but their occurrence
  # counter is incremented.
  def self.save(hash)
    hash = hash.dup
    collection = Mongo.db[hash.delete("token")]
    selector = { :id => hash["id"] }

    if collection.find(selector).any?
      collection.update(selector, { :$inc => { :occurrences => 1 } })
    else
      hash[:occurrences] = 1

      if hash["groups"] 
        if hash["groups"].is_a?(Hash) && hash["groups"]["group"]
          hash["groups"] = Array.wrap(hash["groups"]["group"])
        end

        if hash["groups"].respond_to?(:each)
          hash["groups"].each do |group|
            if group["attributes"].is_a?(Hash) && group["attributes"]["attribute"]
              group["attributes"] = Array.wrap(group["attributes"]["attribute"])
            end
          end
        end
      end

      collection.insert(hash)

      Mailer.notification(hash["id"], hash["title"], collection.name).deliver
    end
  end

  # Returns an Array of all groups for this notification.
  #
  # Groups are not instantiated by Nofication.find, because they are not needed
  # most of the time.
  def groups
    if self.document && self.document["groups"]
      document["groups"].map { |group| Group.new(group) }
    else
      []
    end
  end

end
