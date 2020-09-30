class CreatePessoas < ActiveRecord::Migration[5.2]
  def change
    create_table :pessoas do |t|
      t.string :nome
      t.string :profissao
      t.string :cep
      t.string :razao_social
      t.string :nome_fantasia
      t.string :cidade
      t.string :endereço
      t.string :cpf
      t.string :rg
      t.string :pis
      t.string :residencial
      t.string :comercial
      t.string :celular
      t.string :nacionalidade
      t.string :estado_civil
      t.string :estado_civil
      t.string :bairro
      t.string :email
      t.string :escolaridade
      t.string :insc_estadual
      t.string :insc_municipal
      t.string :responsável
      t.string :cnpj
      t.references :cadastro_atendimento, foreign_key: true
      t.string :usuario
      t.string :update_objt

      t.timestamps
    end
  end
end
