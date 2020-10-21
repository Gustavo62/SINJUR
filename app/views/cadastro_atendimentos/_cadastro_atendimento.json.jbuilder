json.extract! cadastro_atendimento, :id, :cnpj_filiado, :codigo_tj_filiado, :nome_solicitante, :cpf_solicitante, :telefone_solicitante, :texto_livre, :created_at, :updated_at
json.url cadastro_atendimento_url(cadastro_atendimento, format: :json)
