class CreateContatos < ActiveRecord::Migration[5.2]
  def change
    create_table :contatos do |t|
      t.string :nome
      t.string :profissao
      t.string :detalhe
      t.string :logradouro
      t.string :bairro
      t.string :cidade
      t.string :observacao
      t.date :dn
      t.string :email
      t.string :site
      t.string :cep
      t.string :numero
      t.string :cidade
      t.string :usuario, default: current_admin.email
      t.timestamps
    end
  end
end
