class User < ActiveRecord::Base
  attr_accessible :date_of_birth, :email, :first_name, :last_name

  has_many :tinks
end
