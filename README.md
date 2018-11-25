# Admission API (2018_11_21 - Challange)

API para gerenciar admissão, matrícula e mensalidades de alunos


# Projeto e Modificações

O projeto foi criado em cima da base passada, com alguns adicionais:
- Adiconado Rubocop para verificar melhores práticas
- Adicionado SimpleCov para covertura de testes (está com 99,02% de cobertura, segundo a ferramenta)
- Ambiente criado com o Docker e cocker-compose (arquivos estão disponíveis no repositório)
- Ajustes e criações de migrations necessárias para implementação
- Os pagamentos gerados para cada mensalidade são dos dois tipos (cartão e boleto), dessa forma, o aluno fica com o poder de escolha sobre qual maneira vai pagar.


## Ambiente Heroku

Para testar em um ambiente web, subi a aplicação para o Heroku, através do seguinte link:
https://ancient-chamber-63130.herokuapp.com/
Há apenas uma pagina inicial com algumas simples informações sobre a API. Pode-se testar utilizando o postman
O ambiente do Heroku foi criado com PostgreSQL pois não há suporte ao SQLite3. Porém, o ambiente de dev está utilizando o SQLite3

## Ambiente de Desenvolvimento
Meu ambiente de desenvolvimento é Linux (Xubuntu), portanto as instruções abaixo são baseadas nesse sistema.
Para testar utilizando o rspec, pode-se utilizar o ambiente de desenvolvimento. Para subi-lo no com o docker, é necessário a instalação das ferramentas:
- Docker (https://docs.docker.com/install/linux/docker-ce/ubuntu/)
- docker-compose (https://docs.docker.com/compose/install/)

### Subindo o ambiente
Para subir o ambiente, primeiramente é necessário construir o container. Para isso, basta entrar na pasta do projeto e rodar o seguinte comando:

```console
foo@pc:~$ docker-compose build
```
Esse comando fará o build e instalação dos componentes necessários ao containter.

Após a instalaçao, pode-se acessar o container com o seguinte comando:
```console
foo@pc:~$ docker-compose run --rm admission_api bash
```
Ao acessa-lo, pode rodar o comando **rspec** para dar inicio aos testes automatizados.
A ferramenta de cobertura de testes mostrará ao final do teste a porcentagem de cobertura. Também criará uma página HTML em coverage/ com mais informações.
