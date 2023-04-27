class AddOrderIdToColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :columns, :order_id, :integer, null: false, unique: true

    max_order_id = Column.maximum(:order_id) || 0
    Column.update_all(order_id: max_order_id + 1)
  end
end
