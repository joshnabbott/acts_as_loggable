class User < ActiveRecord::Base
  cattr_accessor :current_user
  has_many :action_logs
end