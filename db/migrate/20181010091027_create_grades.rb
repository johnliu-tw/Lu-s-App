class CreateGrades < ActiveRecord::Migration[5.1]
  def change
    create_table :grades do |t|
      t.string :date
      t.integer :grade
      t.string :description

      t.timestamps
    end
  end
end
