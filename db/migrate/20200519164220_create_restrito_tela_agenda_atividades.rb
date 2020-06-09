class CreateRestritoTelaAgendaAtividades < ActiveRecord::Migration[5.2]
  def change
    create_table :restrito_tela_agenda_atividades do |t|
      t.string :tipo
      t.string :titulo
      t.string :nivel
      t.text :resumo
      t.date :agendamento

      t.timestamps
    end
  end
end
