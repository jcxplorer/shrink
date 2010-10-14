class Project < ActiveRecord::Base
  has_many :users, :through => :involvements
  has_many :involvements, :dependent => :delete_all

  attr_accessible :name, :user_ids

  validates_presence_of :name

  before_create :generate_token

  # Fetch notifications for this project.
  #
  # This will just call Notification.find, so look there for documentation on
  # the parameters.
  def notifications(selector={}, opts={})
    Notification.find(self.token, selector, opts)
  end

  private

  # The project token is used by the API as a sort of authentication token,
  # and by MongoDB for the collection name where notifications are stored.
  def generate_token
    self.token = SecureRandom.hex(32)
  end
end
