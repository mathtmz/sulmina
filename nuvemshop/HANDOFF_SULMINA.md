# Sulmina — contexto de continuidade

Atualizado em 25/11/2026. Este handoff descreve a cópia de trabalho, a loja ativa e o fluxo seguro para manter o tema sincronizado. Não contém credenciais.

## Projeto e repositório

- Loja pública: `https://sulmina.com.br/`
- Repositório Git: `https://github.com/mathtmz/sulmina`
- Clone local neste Mac: `/Users/matheustomaz/work/SULMINA/sulmina-site`
- Tema clássico da Nuvemshop: `nuvemshop/`
- Branch de trabalho: `codex/padronizar-cartoes-produtos`; o `main` é a branch principal.
- A cópia ativa do FTP é a referência original do tema. Compare o servidor de novo antes de qualquer envio, para preservar alterações feitas no painel ou no FTP após a última sincronização.
- A conexão fica fora do repositório em `/Users/matheustomaz/work/SULMINA/.ftp-netrc`. Leia as credenciais somente em memória; nunca as exiba, registre ou versione.

## Estrutura do tema

- `layouts/`: estrutura do tema e carregamento dos estilos e scripts Sulmina.
- `templates/`: páginas de início, produto e outras páginas da loja.
- `snipplets/`: componentes de produtos, filtros, produtores, header, footer e carrinho.
- `static/css/sulmina.css`: identidade visual, grades e responsividade.
- `static/js/sulmina.js`: filtros da loja, preço promocional exibido na página do produto e ajustes de interface.
- `static/js/store.js.tpl`: integrações e comportamentos baseados no JavaScript original da Nuvemshop.
- `config/`: campos e valores editáveis pelo editor do tema.

## Gestão pelo painel da Nuvemshop

Produtos, preços, estoque, variações, páginas, pedidos, frete, carrinho e checkout continuam administrados nos recursos nativos da Nuvemshop. O tema fornece apresentação e integrações.

Na página inicial, o editor concentra hero, produtores, produtos, processo e conteúdo institucional. A grade de produtores tem três posições preenchidas e não deixa espaços reservados; “Nossos cafés” usa um carrossel de quatro cards por vez no desktop, duas colunas em larguras intermediárias e um card no celular.

A página `/produtores/` e a home usam até oito perfis configurados no editor em **Página inicial → Módulo 3 — Quem faz o seu café**. Preencha o nome para ativar cada perfil. Os produtos usam a tag `produtor:<slug>` como referência, sem duplicar o perfil. Cada perfil pode incluir nome, cidade/estado, selo, frase, biografia de 5 a 7 linhas, logo/foto de perfil, capa e link da história.

Na Loja, os filtros abrem em painel, começam fechados e oferecem somente opções disponíveis entre os produtos. As tags reconhecidas incluem `torra:clara|media|escura`, `moagem:grao|moido`, `produtor:<slug>` e `nota:...` para as notas sensoriais.

Os botões de variação mostram o peso lido do cadastro do produto, por exemplo `Grãos | 250g`. Na página do produto, a partir de três unidades, a apresentação mostra preço cheio, desconto de 15% e o preço promocional calculado sobre o preço cheio. O carrinho e o checkout permanecem nativos da Nuvemshop.

## Publicação e sincronização

1. Leia `PROJECT_CONTEXT.md`, este arquivo e `nuvemshop/README.md`.
2. Confira `git status`, branch e histórico. Preserve mudanças existentes e nunca inclua `.DS_Store`, `.nuvem`, `.env`, tokens, senhas ou credenciais.
3. Antes de publicar no site, confira a cópia atual do FTP por FTPS explícito com TLS, `prot_p()` e modo passivo. Não use sincronização integral com força; envie somente os arquivos necessários e baixe-os novamente para comparar.
4. Para sincronizar com GitHub, faça commit em branch de trabalho e integre ao `main` por pull request. Não inclua credenciais ou configurações privadas.
5. Diferencie no registro o que foi observado no site público, conferido no FTP e enviado ao GitHub.

## Histórico recente

- Os cartões de produtos, filtros, variantes com peso, home e página de produtores foram implementados no tema e sincronizados com o FTP.
- A página de produto passou a exibir o valor promocional de 15% ao selecionar três unidades ou mais, com desconto calculado sobre o preço cheio.
- A faixa marrom de frete grátis foi removida da página de produto; o anúncio verde do topo permanece.
- Em 25/11/2026, os 24 arquivos de tema alterados localmente foram comparados com a cópia ativa do FTP e estavam idênticos. A sincronização com o GitHub ainda deve seguir o fluxo de branch e pull request descrito acima.
