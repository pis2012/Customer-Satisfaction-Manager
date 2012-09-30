class Comment < ActiveRecord::Base

  belongs_to :feedback, :user

  attr_accessible :feedback, :user,
                  :content, :created_at, :updated_at
end
