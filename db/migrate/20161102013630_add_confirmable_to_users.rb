class AddConfirmableToUsers < ActiveRecord::Migration[5.0]
  # I like to use up/down anyway, but it's important here because there
  # is no reverse method for the User table update query.
  def up
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
		add_column :users, :confirmation_sent_at, :datetime
		add_index :users, :confirmation_token, unique: true

    # Updates existing users to have a confirmed_at value set.
		execute("UPDATE users SET confirmed_at = CURRENT_TIMESTAMP")
  end
  def down
		remove_columns :users, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
