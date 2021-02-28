class AddSubscriberToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :subscriber, :bool, default: false
  end
end
