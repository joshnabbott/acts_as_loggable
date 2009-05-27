class ActionLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :loggable, :polymorphic => true

  def user_name
    user ? user.name : "Unknown User #{user_id}"
  end
end