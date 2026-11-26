# Sulmina — contexto do projeto

Leia este guia antes de alterar o repositório. Ele explica onde está cada parte do projeto e como preservar a separação entre a referência estática e a loja Nuvemshop.

## Estrutura

```text
sulmina/
├── README.md
├── PROJECT_CONTEXT.md
├── site/       # site estático original e referência visual
└── nuvemshop/  # tema clássico personalizado da loja
```

### `site/`

Contém as páginas HTML e os assets do site original. O conteúdo foi movido com `git mv` nesta branch para preservar o histórico Git. Use-o para comparar conteúdo, imagens e identidade visual. O site contém protótipos estáticos; carrinho e checkout aqui não representam os fluxos comerciais produtivos.

### `nuvemshop/`

Contém os arquivos do tema clássico: `config/`, `layouts/`, `snipplets/`, `static/` e `templates/`. A gestão de catálogo, estoque, preços, variações, páginas, newsletter, carrinho e checkout deve continuar nas ferramentas nativas da Nuvemshop. O código fornece o template, a apresentação e as integrações.

Para contexto técnico do tema e operação, leia [`nuvemshop/README.md`](nuvemshop/README.md) e [`nuvemshop/HANDOFF_SULMINA.md`](nuvemshop/HANDOFF_SULMINA.md).

## Regras de trabalho

- Repositório remoto: [`mathtmz/sulmina`](https://github.com/mathtmz/sulmina); branch principal: `main`.
- Preserve o histórico já existente no `main`; integre mudanças por pull request.
- Não versione arquivos `.nuvem`, `.env`, tokens, senhas ou credenciais.
- Não publique alterações na loja Nuvemshop sem solicitação explícita.
- A marca representa produtos do Sul de Minas em geral; café é a primeira coleção, não o limite da marca.
- Ao revisar o site publicado, diferencie claramente observação ao vivo de inspeção do código local.

## Cópia FTP neste Mac — 22/11/2026

- Clone principal: `~/work/SULMINA/sulmina-site`; o tema está em `nuvemshop/`.
- O tema ativo foi baixado para `~/work/SULMINA/ftp-original` e comparado com `main` no commit `75defb4`. Havia sete arquivos diferentes; a branch `codex/padronizar-cartoes-produtos` parte dessa cópia FTP e inclui a alteração do cartão.
- A configuração privada de acesso fica fora dos repositórios em `~/work/SULMINA/.ftp-netrc`, com permissões restritas. Nunca leia para exibir, compartilhe ou versione o conteúdo.
- O FTP é a referência original conforme instrução do usuário. Antes de qualquer envio, faça nova comparação com o FTP para não sobrescrever mudanças posteriores. Publicar requer pedido explícito.
- Em 22/11/2026, com autorização, foi publicado somente `snipplets/home/home-product-card.tpl` para padronizar origem, torra e notas dos cartões. `ftp-original` continua sendo o registro anterior à alteração, não uma cópia atual do arquivo publicado. Detalhes e validação: `~/work/SULMINA/sulmina/gen-ai/site/PADRONIZACAO_CARTOES_2026-11-22.md`.
- Ainda em 22/11, produtos similares passaram a usar esse mesmo cartão por meio de `snipplets/product/related-product-card.tpl`; `product-related.tpl` e o cartão compartilhado também foram atualizados no FTP. O cartão sincroniza a origem nas cópias geradas pelo carrossel.
- Em 22/11, os três parceiros foram cadastrados no editor do tema e exibidos em `/produtores/` e na home; o quarto perfil foi desativado. Campos do produtor e da página foram reunidos em Página inicial → Módulo 3. Em 24/11, a cidade da Doceira foi corrigida para Campos Gerais/MG no cadastro, nas descrições dos três produtos e nos cartões do tema; Grão Bão permanece em Campos Gerais/MG. Registro original: `~/work/SULMINA/sulmina/gen-ai/site/PRODUTORES_2026-11-22.md`.
- Em 22/11/2026, os três cadastros Grão Bão foram revisados no painel usando a planilha FORNECEDORES; a descrição, marca e tags incorretas de Doceira foram removidas do café de mel e tangerina. Registro detalhado: `~/work/SULMINA/sulmina/gen-ai/site/CADASTRO_GRAO_BAO_2026-11-22.md`. O usuário confirmou em 22/11/2026 que todos os cafés Grão Bão são nanolotes; descrições e tags dos três foram atualizadas. A planilha ainda contém divergências.

## Histórico desta reorganização

Esta branch parte do `main` existente do repositório `mathtmz/sulmina`. Ela preserva as páginas e assets originais em `site/` e acrescenta os arquivos produtivos do tema em `nuvemshop/`. O arquivo local `.nuvem` não deve ser copiado nem commitado.
- Em 22/11, o cadastro compartilhado de produtores foi ampliado no tema clássico para oito posições: preenchimento do nome ativa o perfil; home e `/produtores/` usam o mesmo cadastro, e produtos se vinculam por `produtor:<slug>`. Foram cadastradas as tags `produtor:doceira-coffees`, `produtor:grao-bao` e `produtor:coopfam` nos oito produtos correspondentes. O editor oferece imagem quadrada e capa horizontal por perfil. Os seis arquivos de tema foram comparados com o FTP ativo e enviados; cada envio foi relido e validado. A prévia confirmou os três produtores na home, os oito cartões vinculados e o quarto perfil vazio. O cartão também remove o nome do produtor repetido no texto de origem. Tags e campos de configuração foram salvos no painel.
- Em 22/11, após cadastrar logos e capas dos três produtores, a grade da home foi ajustada para usar três colunas com os três perfis ativos; “Nossos cafés” passou a mostrar quatro cards por linha no desktop, duas colunas em telas intermediárias e uma no celular. As grades foram publicadas pelo editor CSS da Nuvemshop e conferidas na home pública.
- Em 23/11, removido o limite CSS de sete linhas das biografias em `/produtores/`; a biografia completa da COOPFAM foi conferida na página pública após publicar o override no editor CSS da Nuvemshop.
