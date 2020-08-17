require 'csv'
namespace :csv do
  desc "Importa o arquivo filiados.csv"
  task import: :environment do
    CSV.foreach('tmp/ResultadoRelatorio-2020-08-13.csv', col_sep: ';').with_index do |linha, indice|
      unless (indice == 0)
        Filiado.create!(titular: linha[27], cei: linha[10], cnpj: linha[7],serventia: linha[10], nome:linha[14], cep:linha[16], logradouro:linha[17], numero_casa:linha[18], complemento:linha[19], bairro:linha[20], telefone_fixo_casa:linha[22], cidade:linha[53], email:linha[25], end_completo:linha[50])
      end
    end 
  end 
end