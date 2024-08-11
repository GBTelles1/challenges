class AddUniqueIndexToClientsFiscalId < ActiveRecord::Migration[7.1]
  def change
    add_index :clients, :fiscal_id, unique: true
  end
end
