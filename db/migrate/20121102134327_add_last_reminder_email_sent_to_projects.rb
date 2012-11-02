class AddLastReminderEmailSentToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :last_reminder_email_sent, :datetime
  end
end
