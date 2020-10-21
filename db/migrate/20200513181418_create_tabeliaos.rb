class CreateTabeliaos < ActiveRecord::Migration[5.2]
  def change
    create_table :tabeliaos do |t|
      t.string :nome
      t.integer :cpf
      t.integer :numero
      t.references :filiado
      t.timestamps
    end
  end
end
