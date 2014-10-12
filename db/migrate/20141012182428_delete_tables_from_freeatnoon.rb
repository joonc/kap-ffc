class DeleteTablesFromFreeatnoon < ActiveRecord::Migration
  def up
    drop_table :free_times
    drop_table :bad_dates
  end
end
