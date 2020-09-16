class CreateDocumentos < ActiveRecord::Migration[5.2]
  def change
    create_table :documentos do |t|
      t.references :cadastro_atendimento
      t.string :descricao
      t.timestamps
    end
  end
end
