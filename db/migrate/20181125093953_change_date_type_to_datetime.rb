class ChangeDateTypeToDatetime < ActiveRecord::Migration[5.1]
  def change
    change_column :grades, :date, :datetime
  end
end
