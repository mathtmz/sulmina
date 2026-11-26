# Sulmina Nuvemshop

Tema customizado da Sulmina para a Nuvemshop.

## Estrutura

- `layouts/`: estrutura principal do tema
- `templates/`: páginas e templates Twig
- `snipplets/`: componentes reutilizáveis
- `static/css/`: estilos da Sulmina e estilos do tema
- `static/js/`: comportamentos JavaScript
- `config/`: configurações editáveis no painel da Nuvemshop

## Sincronização com a Nuvemshop

O arquivo `.nuvem` contém a conexão FTP e não faz parte deste repositório. Para sincronizar, configure a conexão localmente e execute a CLI oficial da Nuvemshop:

```powershell
node path\to\@tiendanube\cli\dist\cli.js theme ftp push --force --yes
```

Nunca publique credenciais FTP no Git.

## Gestão pelo painel da Nuvemshop

No editor do tema, em **Página de início**, o bloco **Conteúdo Sulmina** controla os textos e as fotos do hero, diferenciais, produtores, produtos, processo e história. O bloco **Página Loja Sulmina** controla o título, a descrição e o banner da Loja.

O catálogo continua sendo administrado em **Produtos**: nome, preço, estoque, variações, descrição e fotos dos anúncios não ficam duplicados no código.

A home segue a ordem editorial **Quem faz o seu café → Nossos cafés → Do Sul de Minas até a sua casa**.

Na home, a grade de produtores ocupa três colunas no desktop para não deixar um espaço reservado sem card; a grade **Nossos cafés** exibe quatro produtos por linha no desktop. Ambas se adaptam para duas colunas em telas intermediárias e uma no celular.

A página nativa **Nossos Produtores** usa um layout editorial próprio. No editor, acesse **Página inicial → Módulo 3 — Quem faz o seu café** para cadastrar até oito perfis. O nome preenchido ativa o perfil; os dados alimentam a home e a página de produtores. A imagem quadrada pode ser usada como logo/foto de perfil; uma capa horizontal é opcional. Inclua nome, cidade/estado, frase curta, selo, biografia de 5 a 7 linhas e, se houver, link da história. O campo identificador define o sufixo da tag `produtor:<slug>` usada nos produtos, por exemplo `produtor:doceira-coffees`. Os cartões e o filtro de produtor leem nome e cidade do cadastro.

O rodapé usa o card **Assine nossa newsletter** quando `news_show` está ativo. O formulário envia nome completo e e-mail para a newsletter nativa da Nuvemshop; não há API externa ou armazenamento próprio de contatos. O título, textos dos campos, botão e mensagem de sucesso também podem ser editados no painel.

Para os filtros da Loja, use estas tags nos produtos:

- `torra:clara`, `torra:media` ou `torra:escura`
- `moagem:grao` ou `moagem:moido`
- `produtor:<slug>` conforme o identificador preenchido em Módulo 3, por exemplo `produtor:doceira-coffees`, `produtor:grao-bao` ou `produtor:coopfam`
- `nota:chocolate`, `nota:caramelo`, `nota:laranja`, `nota:floral`, `nota:nozes`, `nota:mel` ou `nota:frutado`

O cartão usa as notas em tags `nota:...` quando existirem; caso contrário, separa as notas do trecho do nome após ` | `, por exemplo `Café | Mel, Tangerina e Frutas Vermelhas`. Um sufixo após ` — ` é tratado como nome da linha, não como nota. A origem pode ser informada por `origem:...` ou no parágrafo da descrição com o prefixo `Origem:`. Como a listagem do tema ativo não disponibiliza a descrição completa, a origem é buscada na página pública do produto quando o cartão se aproxima da área visível; se a busca falhar, ela pode não aparecer. A torra vem de `torra:...`, da tag usual `torra média`/`torra-média` ou da descrição. As opções de moagem são lidas das variações nativas. O código anterior contém valores de reserva para produtos específicos; mantenha o cadastro coerente e atualizado e confira a exibição ao alterar produtos.

Páginas institucionais continuam nativas: crie ou edite o conteúdo em **Páginas** e aponte os links pelo editor do tema ou pelo menu da loja. O HTML/CSS permanece responsável somente pelo template visual, responsividade e integração com carrinho, checkout e catálogo.
