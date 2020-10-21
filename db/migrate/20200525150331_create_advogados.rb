class CreateAdvogados < ActiveRecord::Migration[5.2]
  def change
    create_table :advogados do |t|
      t.string :nome
      t.string :endereço
      t.string :cidade
      t.string :bairro
      t.string :cep
      t.string :telefone
      t.string :cidade
      t.string :email
      t.string :advogado
      t.string :oab
      t.string :telefone
      t.string :observação
      t.references :cadastro_atendimento, foreign_key: true
      t.string :usuario
      t.string :update_objt

      t.timestamps
    end
  end
end
