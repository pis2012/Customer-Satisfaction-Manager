class CreateFeedbackTypes < ActiveRecord::Migration
  def change
    create_table :feedback_types do |t|

      t.string :name
      t.string :image_url
    end
  end
end
