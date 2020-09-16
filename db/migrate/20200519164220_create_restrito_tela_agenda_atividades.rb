class CreateRestritoTelaAgendaAtividades < ActiveRecord::Migration[5.2]
  def change
    create_table :restrito_tela_agenda_atividades do |t|
      t.string :tipo
      t.string :titulo
      t.string :nivel
      t.string :status
      t.text :resumo
      t.datetime :agendamento
      t.string :usuario
      t.string :update_objt
      
      t.timestamps
    end
  end
end
