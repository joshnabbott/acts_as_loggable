class Product < ActiveRecord::Base
  acts_as_loggable :only => [ :update, :destroy ]
end