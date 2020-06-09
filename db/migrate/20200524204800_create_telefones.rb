class CreateTelefones < ActiveRecord::Migration[5.2]
  def change
    create_table :telefones do |t|
      t.string :telefone
      t.references :contato, foreign_key: true 
      t.timestamps
    end
  end
end
