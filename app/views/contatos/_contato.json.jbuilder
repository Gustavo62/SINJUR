json.extract! contato, :id, :nome, :profissao, :detalhe, :logradouro, :bairro, :cidade, :observacao, :dn, :email, :site, :cep, :numero, :cidade, :created_at, :updated_at
json.url contato_url(contato, format: :json)
