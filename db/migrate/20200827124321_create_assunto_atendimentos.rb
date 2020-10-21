class CreateAssuntoAtendimentos < ActiveRecord::Migration[5.2]
  def change
    create_table :assunto_atendimentos do |t|
      t.string :assunto
      t.text :descricao
      t.string :usuario
      t.string :update_objt
      
      t.timestamps
    end
  end
end
