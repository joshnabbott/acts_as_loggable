class Image < ActiveRecord::Base
  acts_as_loggable :except => [ :destroy ]
end