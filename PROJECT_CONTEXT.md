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

## Histórico desta reorganização

Esta branch parte do `main` existente do repositório `mathtmz/sulmina`. Ela preserva as páginas e assets originais em `site/` e acrescenta os arquivos produtivos do tema em `nuvemshop/`. O arquivo local `.nuvem` não deve ser copiado nem commitado.
