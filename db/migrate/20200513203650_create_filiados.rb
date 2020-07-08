class CreateFiliados < ActiveRecord::Migration[5.2]
  def change
    create_table :filiados do |t|
      t.integer :cnpj
      t.integer :cei
      t.integer :serventia 
      t.integer :cep
      t.integer :numero_casa
      t.integer :telefone_fixo_casa
      t.string :nome 
      t.string :logradouro 
      t.string :complemento
      t.string :bairro 
      t.string :cidade
      t.string :email 
      t.references :cadastro_atendimento

      t.timestamps
    end
  end
end
