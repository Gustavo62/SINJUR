class CreateProcessos < ActiveRecord::Migration[5.2]
  def change
    create_table :processos do |t|

      t.timestamps
    end
  end
end
