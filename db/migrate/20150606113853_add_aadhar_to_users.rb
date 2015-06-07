class AddAadharToUsers < ActiveRecord::Migration
  def change
    add_column :users, :aadhar, :string
  end
end
