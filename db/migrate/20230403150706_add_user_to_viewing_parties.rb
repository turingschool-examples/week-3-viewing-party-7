class AddUserToViewingParties < ActiveRecord::Migration[7.0]
  def change
    add_reference :viewing_parties, :user, foreign_key: true
  end
end
