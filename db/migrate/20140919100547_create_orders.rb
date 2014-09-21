class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.date :consult_date
      t.time :consult_time
      t.date :delivery_date
      t.time :delivery_time

      t.timestamps
    end
  end
end
