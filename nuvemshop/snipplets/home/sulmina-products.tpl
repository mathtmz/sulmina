{% set home_products = sections.primary.products %}
{% if not home_products %}{% set home_products = sections.new.products %}{% endif %}
{% set home_products_title = settings.home_products_title | default('Nossos cafés') %}
{% set home_products_link_text = settings.home_products_link_text | default('Ver todos os cafés →') %}

<section class="sulmina-products" data-store="home-products-featured">
    <div class="sulmina-container">
        <div class="sulmina-section-heading sulmina-section-heading--center"><h2>{{ home_products_title }}</h2></div>
        {% if home_products %}
            <div class="sulmina-product-grid">
                {% for product in home_products %}{% include 'snipplets/home/home-product-card.tpl' %}{% endfor %}
            </div>
        {% else %}
            <div class="sulmina-empty-state"><p>Escolha os produtos que deseja destacar na página inicial pelo catálogo da Nuvemshop.</p></div>
        {% endif %}
        <p class="sulmina-centered"><a class="sulmina-text-link" href="{{ store.products_url }}">{{ home_products_link_text }}</a></p>
    </div>
</section>
