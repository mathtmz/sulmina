{% set home_hero_title = settings.home_hero_title | default('O Sul de Minas, direto na sua casa.') %}
{% set home_hero_description = settings.home_hero_description | default('Café especial de produtores com nome, rosto e história — da nossa terra, pra sua mesa.') %}
{% set home_hero_primary_text = settings.home_hero_primary_text | default('Comprar agora') %}
{% set home_hero_primary_url = settings.home_hero_primary_url | default(store.products_url) %}
{% set home_hero_secondary_text = settings.home_hero_secondary_text | default('Conhecer os produtores') %}
{% set home_hero_secondary_url = settings.home_hero_secondary_url | default('/produtores/') %}
{% if home_hero_secondary_url == '#sulmina-produtores' or home_hero_secondary_url == '/paginas/produtores/' %}{% set home_hero_secondary_url = '/produtores/' %}{% endif %}
{% set home_hero_image = 'home_hero_image.jpg' | has_custom_image %}

<section class="sulmina-hero{% if home_hero_image %} sulmina-hero--image{% endif %}" data-store="home-sulmina-hero"{% if home_hero_image %} style="--sulmina-hero-image: url('{{ 'home_hero_image.jpg' | static_url | settings_image_url('1080p') }}');"{% endif %}>
    <div class="sulmina-container sulmina-hero__inner">
        <div class="sulmina-hero__copy">
            <h1>{{ home_hero_title }}</h1>
            <p class="sulmina-hero__lead">{{ home_hero_description }}</p>
            <div class="sulmina-actions">
                <a class="sulmina-button sulmina-button--gold" href="{{ home_hero_primary_url }}">{{ home_hero_primary_text }}</a>
                <a class="sulmina-button sulmina-button--outline" href="{{ home_hero_secondary_url }}">{{ home_hero_secondary_text }}</a>
            </div>
        </div>
    </div>
</section>
