class CreateProcessos < ActiveRecord::Migration[5.2]
  def change
    create_table :processos do |t|
      t.string :status_processo
      t.string :area_atuacao
      t.string :objeto_acao
      t.string :assunto
      t.string :detalhe
      t.string :pasta
      t.string :etiqueta
      t.string :favorito
      t.string :local_tramite_um
      t.string :local_tramite_dois
      t.references :cadastro_atendimento, foreign_key: true
      t.string :usuario, default: current_admin.email
      t.string :update_objt, default: current_user

      t.timestamps
    end
  end
end
