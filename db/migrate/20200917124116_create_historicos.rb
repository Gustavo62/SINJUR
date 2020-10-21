class CreateHistoricos < ActiveRecord::Migration[5.2]
  def change
    create_table :historicos do |t|
      t.string :usuarioudt
      t.string :acaoupdt
      t.datetime :hracao
      t.datetime :hrup
      t.string :usuario
      t.string :acao_desc 
      t.string :acao 
      t.string :objeto 
      t.string :quem
      t.string :objeto_id
      t.string :quem_username

      t.timestamps
    end
  end
end
