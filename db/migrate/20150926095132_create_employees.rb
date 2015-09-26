class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :freelancer_id

      t.timestamps null: false
    end
  end
end
