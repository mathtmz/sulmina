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

A página nativa **Nossos Produtores** usa um layout editorial próprio. No bloco **Página Nossos Produtores** do editor, é possível alterar o título, descrição, fotos, nomes, locais, selos, biografias e links dos quatro produtores, além da chamada final para novos produtores. Os nomes, locais e fotos reaproveitam os campos dos produtores exibidos na home.

O rodapé usa o card **Assine nossa newsletter** quando `news_show` está ativo. O formulário envia nome completo e e-mail para a newsletter nativa da Nuvemshop; não há API externa ou armazenamento próprio de contatos. O título, textos dos campos, botão e mensagem de sucesso também podem ser editados no painel.

Para os filtros da Loja, use estas tags nos produtos:

- `torra:clara`, `torra:media` ou `torra:escura`
- `moagem:grao` ou `moagem:moido`
- `produtor:dona-marta`, `produtor:joao-lucio` ou `produtor:familia-andrade`
- `nota:chocolate`, `nota:caramelo`, `nota:laranja`, `nota:floral`, `nota:nozes`, `nota:mel` ou `nota:frutado`

Páginas institucionais continuam nativas: crie ou edite o conteúdo em **Páginas** e aponte os links pelo editor do tema ou pelo menu da loja. O HTML/CSS permanece responsável somente pelo template visual, responsividade e integração com carrinho, checkout e catálogo.
