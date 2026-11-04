# Sulmina — contexto para continuidade

Atualizado em 04/11/2026. Este documento reúne o contexto útil para continuar o trabalho em outra conversa. Não contém senhas, tokens ou credenciais.

## Objetivo do projeto

Adaptar o site Sulmina para um tema clássico personalizado da Nuvemshop, mantendo o visual do site de referência e deixando a gestão diária de conteúdo, produtos, páginas, imagens e newsletter nas ferramentas nativas da Nuvemshop.

- Referência original: `https://mathtmz.github.io/sulmina/`
- Loja: `https://sulmina.com.br/`
- Repositório Git: `https://github.com/mathtmz/sulmina`; os arquivos do tema ficam em `nuvemshop/`.
- Pasta do tema neste repositório: `nuvemshop/`.
- A cópia de trabalho anterior ficou em `D:\Projects\code\sulmina`; não use essa cópia para inferir o estado atual do GitHub.
- Arquivos locais de conexão `.nuvem` podem existir fora do repositório. Não leia, exponha, compartilhe nem inclua esses arquivos em commits/documentos.

O Morelia é o tema original/rollback e não deve ser alterado. O trabalho customizado usa a infraestrutura necessária da Nuvemshop, mas o markup e a identidade visual são da Sulmina. Produtos, preços, estoque, variações, carrinho e checkout devem continuar nativos da Nuvemshop.

## Diretrizes de marca e conteúdo

- A Sulmina representa produtos do Sul de Minas em geral; começa com cafés, mas não deve ser posicionada como marca exclusivamente de café.
- Idioma: português do Brasil.
- Preservar a identidade visual editorial e acolhedora do site de referência: tons de creme/papel, café/terracota e dourado, serifas nos títulos e sans-serif no corpo.
- Evitar conteúdo comercial simulado em produção. Os produtos reais devem vir do catálogo Nuvemshop.
- O modo pré-lançamento está ativo na home pública. A mensagem aprovada é ampla e apresenta os cafés apenas como primeira coleção.
- O usuário quer que edição cotidiana aconteça no painel/editor da Nuvemshop; código deve prover estrutura, módulos e integrações, não exigir edição manual recorrente.

## Escopo já trabalhado no tema

Ao longo do projeto foram customizados home e módulos, header, loja/listagem e filtros, cards de produto, produtores, história, jornal/blog, páginas de ajuda/conta/contato, rodapé e newsletter. A newsletter usa o recurso nativo da Nuvemshop; nome e e-mail são campos obrigatórios, sem armazenamento externo. O checkout, carrinho, login e catálogo permanecem nativos.

O usuário pediu que cada seção da home seja um módulo editável pelo editor do tema, incluindo cores de fonte, títulos, cards e fundo. As páginas Loja e Nossos Produtores devem continuar conectadas às páginas/menu e recursos nativos da Nuvemshop. O rodapé deve seguir o site original, com newsletter antes do footer, páginas do site agrupadas sem espaçamentos excessivos e Instagram com ícone + texto.

## Pedido atual: validar a página de produto

Página alvo:

`https://sulmina.com.br/produtos/cafe-doceira-manga-frutas-vermelhas/`

Os requisitos a validar, sem comprar nem alterar dados da loja:

1. A página do produto tem hierarquia visual comercial clara; em particular, o preço deve se destacar do texto descritivo.
2. Ao selecionar **Grãos**, a imagem principal/miniatura deve corresponder à variação em grãos.
3. Ao selecionar **Moído**, a imagem principal/miniatura deve corresponder à variação moída.
4. Confirmar se as seleções ficam visualmente marcadas e se o restante do formulário (quantidade e botão Comprar) continua funcional.

### Evidência de código local

- `nuvemshop/snipplets/product/product-form.tpl` contém o `#price_display` da página de produto.
- `nuvemshop/static/css/sulmina.css` (aprox. linhas 1509–1519) define o preço com fonte de 30–36 px, peso 700 e sublinhado/borda dourada.
- `nuvemshop/static/js/store.js.tpl` (aprox. linhas 2733–2755) escuta a mudança de variação, lê `variant.image` ou `variant.image_id`, localiza o slide com o mesmo `data-image` e move o carrossel/miniatura para ele.
- A lógica de imagem só pode funcionar se cada variação no catálogo Nuvemshop estiver associada à imagem certa. Se não houver associação de imagem para Grãos/Moído, o script não tem como inferir a foto correspondente.

Essa evidência confirma que há regras implementadas no código local; **não confirma o comportamento no site publicado**.

### Bloqueio encontrado no site público

As consultas HTTP ao endereço do produto e à raiz da loja retornaram a página de pré-lançamento (HTTP 200), com título “Do Sul de Minas, para a sua casa.” e o marcador `sulmina-prelaunch`. A resposta não contém o markup de produto (`data-store="product-detail"`), galeria `js-product-slide` nem controles `js-variation-option`. Assim, essa cópia pública não permite testar as variações.

O HTML da home contém no rodapé um `<details>` com o texto **Acesso da equipe**; ao expandir, ele revela um formulário de senha. O usuário explicou que esse é o botão correto para revelar o formulário de acesso. Tentativas anteriores de autenticação via requisição HTTP não liberaram o produto. Não concluir que a senha está errada: pode ser necessário autenticar na sessão de navegador interativa.

**Nunca incluir a senha que o usuário compartilhou em arquivos, respostas, commits ou registros. Não pedir que seja enviada novamente no chat.** Se uma autenticação for necessária, preferir que o usuário a conclua diretamente na sessão de navegador.

## Estado das ferramentas de navegador

Houve confusão entre três mecanismos. O usuário quer o **Browser interno do ChatGPT**, indicado por `[@Browser](plugin://browser@openai-bundled)`, e não o Chrome. A extensão do Chrome e a integração TinyFish foram alternativas discutidas, mas não são a ferramenta que o usuário pediu nesta etapa.

Na conversa anterior, o contexto ambiente mostrava apenas a URL da guia. As ferramentas então expostas permitiam abrir uma página, mas não controlar seus elementos, nem obter screenshot/DOM. O seletor `@Browser` não ficou disponível como ferramenta executável nessa sessão. Escrever `@Browser` como texto não necessariamente ativa a ferramenta: ela precisa ser selecionada no menu de ferramentas/menções da interface. Uma conversa derivada com o histórico foi aberta, mas o controle não foi efetivamente conectado; portanto nenhum teste interativo foi concluído.

Ao continuar:

1. Verificar se a ferramenta nativa Browser está realmente disponível no seletor desta conversa; selecionar a ferramenta, não apenas mencionar seu nome em texto.
2. Usar a página de produto no Browser interno, e deixar o usuário completar o acesso se a sessão exigir senha.
3. Testar Grãos e Moído, registrar qual imagem e miniatura ficam ativas e avaliar o destaque do preço.
4. Se Browser não estiver disponível como ferramenta, declarar o bloqueio com precisão. Não afirmar que navegou/testou. O código local e uma captura de tela servem para revisão parcial, mas não substituem o teste das interações.

## Regras para a próxima rodada

- O pedido atual é de **validação**, não de alteração do tema, publicação ou compra.
- Não publicar, editar o catálogo, associar imagens às variações ou mudar o modo pré-lançamento sem pedido claro.
- Separar sempre: (a) o que foi observado no site ao vivo; (b) o que foi inferido do código local; (c) o que ficou bloqueado.
- Se um requisito falhar no teste, diagnosticar primeiro se é CSS/JS do tema, associação de imagem/ID da variação no catálogo ou versão/caching do tema publicado.
- O usuário se frustrou com afirmações repetidas de acesso a navegador sem controle real. Seja direto sobre o estado da ferramenta e só confirme teste depois de observar a interação.
