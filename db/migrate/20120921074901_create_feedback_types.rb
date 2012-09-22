class CreateFeedbackTypes < ActiveRecord::Migration
  def change
    create_table :feedback_types do |t|

      t.string :name
    end
  end
end
