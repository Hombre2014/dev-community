# frozen_string_literal: true

class AddContactNumberToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :contact_number, :string
  end
end
