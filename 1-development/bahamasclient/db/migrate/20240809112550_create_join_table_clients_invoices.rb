class CreateJoinTableClientsInvoices < ActiveRecord::Migration[7.1]
  def change
    create_join_table :clients, :invoices do |t|
      # t.index [:client_id, :invoice_id]
      # t.index [:invoice_id, :client_id]
    end
  end
end
