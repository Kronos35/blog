class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.references :user, foreign_key: true
      t.references :recipient, foreign_key: { to_table: :users }

      t.timestamps

      t.index %w[user_id recipient_id], unique: true
    end
  end
end
