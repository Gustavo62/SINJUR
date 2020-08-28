class CreateCadastroAtendimentos < ActiveRecord::Migration[5.2]
  def change
    create_table :cadastro_atendimentos do |t|
      t.integer :codigo_tj_filiado 
      t.text :texto_livre
      t.text :editor1
      t.string :nome
      t.string :tipo_processo
      t.string :assunto_atend
      t.integer :cpf
      t.integer :telefone
      t.string :status
      t.date :data_atendimento 
      t.timestamps
    end
  end
end
