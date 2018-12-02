class ChangeDateTypeToDatetime < ActiveRecord::Migration[5.1]
  def change
    change_column :grades, :date, 'date USING date::timestamp without time zone'
  end
end
