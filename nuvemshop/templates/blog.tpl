<main class="sulmina-journal">
    <section class="sulmina-journal__hero">
        <div class="sulmina-container">
            <p class="sulmina-journal__eyebrow">Jornal Sulmina</p>
            <h1>Jornal do Sul de Minas</h1>
            <p>Histórias, cultura e o mundo do café especial da nossa região.</p>
            <nav class="sulmina-journal__topics" aria-label="Temas do Jornal">
                <span class="sulmina-journal__topic sulmina-journal__topic--active">Todas</span>
                <span class="sulmina-journal__topic">Histórias de Produtores</span>
                <span class="sulmina-journal__topic">Café &amp; Preparo</span>
                <span class="sulmina-journal__topic">Sul de Minas</span>
            </nav>
        </div>
    </section>

    <section class="sulmina-journal__body">
        <div class="sulmina-container">
            {% if blog.posts %}
                <div class="sulmina-journal__grid">
                    {% for post in blog.posts %}
                        <article class="sulmina-journal-card">
                            {{ component(
                                'blog/blog-post-item', {
                                    image_lazy: true,
                                    image_lazy_js: true,
                                    post_item_classes: {
                                        item: 'sulmina-journal-card__inner',
                                        image_container: 'sulmina-journal-card__image',
                                        image: 'sulmina-journal-card__image-file img-absolute img-absolute-centered fade-in',
                                        information: 'sulmina-journal-card__information',
                                        title: 'sulmina-journal-card__title',
                                        summary: 'sulmina-journal-card__summary',
                                        read_more: 'sulmina-journal-card__read-more',
                                    },
                                })
                            }}
                        </article>
                    {% endfor %}
                </div>
                {% include 'snipplets/grid/pagination.tpl' with {'pages': blog.pages} %}
            {% else %}
                <div class="sulmina-journal__empty">
                    <p class="sulmina-journal__eyebrow">Em breve</p>
                    <h2>Histórias da nossa terra.</h2>
                    <p>Estamos preparando os primeiros textos do Jornal Sulmina. Novos posts publicados no painel da Nuvemshop aparecerão aqui automaticamente.</p>
                </div>
            {% endif %}
        </div>
    </section>
</main>
