class AddBrowserInfoToLoginActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :login_activities, :browser_name, :string
    add_column :login_activities, :browser_version, :string
  end
end
