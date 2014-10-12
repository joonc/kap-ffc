class AddYearTeamFunFactToUser < ActiveRecord::Migration
  def change
    add_column :users, :year, :integer
    add_column :users, :team, :string
    add_column :users, :fun_fact, :string
  end
end
