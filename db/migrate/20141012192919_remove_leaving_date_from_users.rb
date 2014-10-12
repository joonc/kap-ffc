class RemoveLeavingDateFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :leaving_date, :timestamp
  end
end
