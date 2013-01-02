class Tink < ActiveRecord::Base
  belongs_to :user
  attr_accessible :date_of_send, :title, :url
end
