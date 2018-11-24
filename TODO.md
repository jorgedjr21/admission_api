# Admission API  TODO (2018_11_21 - Challange)

Sugestões de melhorias

## Segurança

- Utilização de um token de segurança para permitir o uso da api para apenas a quem o possui
- Autenticação para a consulta de dados do aluno

## Arquitetura
- Substituição do SQLite3 por outro banco mais robusto (Postgres ou Mysql)

## Código
- Refatoração das factories para melhor uso das mesmas
- Ajuste no retorno do erro quando não é possivel criar um billing (devido a erros na geração das bills ou payments)
- Internacionalização das mensagens de erro
