class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :project_type
      t.integer :from_language_id
      t.integer :to_language_id
      t.references :user

      t.timestamps null: false
    end
  end
end
