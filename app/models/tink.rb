class Tink < ActiveRecord::Base
  belongs_to :user
  attr_accessible :updated_at, :title, :url
  attr_accessor :receiver
end
