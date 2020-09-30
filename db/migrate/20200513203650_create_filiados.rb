class CreateFiliados < ActiveRecord::Migration[5.2]
  def change
    create_table :filiados do |t|
      t.string :cnpj
      t.string :titular
      t.string :cei
      t.string :serventia 
      t.string :cep
      t.string :end_completo
      t.string :numero_casa
      t.string :telefone_fixo_casa
      t.string :nome 
      t.string :logradouro 
      t.string :complemento
      t.string :bairro 
      t.string :cidade
      t.string :email 
      t.references :cadastro_atendimento 
      t.string :usuario
      t.string :update_objt
      t.string :usuario
      t.string :update_objt

      t.timestamps
    end
  end
end
