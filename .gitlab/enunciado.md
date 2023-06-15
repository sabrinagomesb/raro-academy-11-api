# Exercício Semana 13

1. Conforme descrevemos no enunciado do nosso sistema, e documentado no nosso swagger, precisamos implementar todas as rotas da api de bolão. Já fizemos um bom avanço durante as aulas, mas é necessário completar todos os requisitos descritos. Para isso, você deverá **implementar a rota de publicação dos palpites do usuário**, garantindo que esta rota funcione conforme descrito no swagger.

2. Ainda cumprindo os requisitos já declarados, você precisará também **implementar a rota de ranking** dos usuários.

3. Surgiu um novo requisito que não foi mapeado anteriormente, mas que precisamos cumprir. Na rota de jogos, precisamos adicionar a pontuação obtida pelo usuário, de acordo com as regras de pontuação do bolão. Você deverá implementar esta nova regra. Não se esqueça de adicionar isto à documentação do swagger.

4. O serviço de importação dos dados da API de futebol foi inicado durante a nossa aula, mas ainda é necessário finaliza-la. Desta forma, você precisa modificar a classe `services/api_futebol_service.rb`, e garantir que:

- a integração crie ou atualize os dados dos jogos, com placares e status de finalização.
- a integração crie ou atualize os dados dos times
