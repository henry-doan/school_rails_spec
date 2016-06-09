class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :mascot
      t.string :year

      t.timestamps null: false
    end
  end
end
