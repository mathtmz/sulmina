{% set home_products = sections.primary.products %}
{% if not home_products %}{% set home_products = sections.new.products %}{% endif %}
{% set home_products_title = settings.home_products_title | default('Nossos cafés') %}
{% set home_products_link_text = settings.home_products_link_text | default('Ver todos os cafés →') %}

<section class="sulmina-products" data-store="home-products-featured">
    <div class="sulmina-container">
        <div class="sulmina-section-heading sulmina-section-heading--center"><h2>{{ home_products_title }}</h2></div>
        {% if home_products %}
            <div class="sulmina-products-carousel" data-sulmina-products-carousel role="region" aria-label="{{ home_products_title }}" aria-roledescription="carrossel">
                <div class="sulmina-product-grid" data-sulmina-products-track role="list" tabindex="0" aria-label="Produtos em destaque">
                    {% for product in home_products %}
                        <div class="sulmina-product-slide" role="group" aria-roledescription="slide" aria-label="{{ loop.index }} de {{ home_products | length }}">
                            {% include 'snipplets/home/home-product-card.tpl' %}
                        </div>
                    {% endfor %}
                </div>
                {% if home_products | length > 4 %}
                    <div class="sulmina-product-carousel-controls">
                        <button class="sulmina-product-carousel-control" type="button" data-sulmina-products-previous aria-label="Cafés anteriores">‹</button>
                        <span class="sulmina-product-carousel-status" data-sulmina-products-status aria-live="polite">1–4 de {{ home_products | length }}</span>
                        <button class="sulmina-product-carousel-control" type="button" data-sulmina-products-next aria-label="Próximos cafés">›</button>
                    </div>
                {% endif %}
            </div>
        {% else %}
            <div class="sulmina-empty-state"><p>Escolha os produtos que deseja destacar na página inicial pelo catálogo da Nuvemshop.</p></div>
        {% endif %}
        <p class="sulmina-centered"><a class="sulmina-text-link" href="{{ store.products_url }}">{{ home_products_link_text }}</a></p>
    </div>
</section>
