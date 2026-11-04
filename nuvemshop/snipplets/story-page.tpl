{% set story_image = 'story_page_image.jpg' | has_custom_image %}
{% set story_title = settings.story_page_title | default('De volta pra casa') %}
{% set story_intro = settings.story_page_intro | default('"Somos do Sul de Minas. Moramos fora — São Paulo, Bahia — e sentimos na pele a falta de um café que fosse de verdade da nossa terra. Esse projeto nasceu dessa saudade, e da vontade de levar quem produz esse café até a mesa de quem mais precisava dele: gente como a gente."') %}
{% set story_customer_title = settings.story_page_customer_title | default('Para você') %}
{% set story_customer_text = settings.story_page_customer_text | default('Acesso fácil a produtos autênticos do Sul de Minas, em qualquer lugar do Brasil — com curadoria e história por trás de cada item.') %}
{% set story_producer_title = settings.story_page_producer_title | default('Para o produtor') %}
{% set story_producer_text = settings.story_page_producer_text | default('Canal de venda direta, com reconhecimento e melhor margem do que os canais tradicionais — o produtor sempre com nome e rosto.') %}
{% set story_cta_title = settings.story_page_cta_title | default('Quero fazer parte') %}
{% set story_cta_button = settings.story_page_cta_button | default('Conhecer nossos cafés') %}
{% set story_cta_url = settings.story_page_cta_url | default('/produtos/') %}

<main class="sulmina-story-page">
    <section class="sulmina-story-page__image" aria-label="Foto dos fundadores ou paisagem simbólica da Serra da Mantiqueira">
        {% if story_image %}
            <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'story_page_image.jpg' | static_url | settings_image_url('large') }}" alt="{{ story_title }}" class="sulmina-story-page__image-file lazyload">
        {% else %}
            <div class="sulmina-story-page__placeholder">Foto dos fundadores / paisagem simbólica da Serra da Mantiqueira</div>
        {% endif %}
    </section>

    <section class="sulmina-story-page__intro">
        <div class="sulmina-story-page__narrow">
            <h1>{{ story_title }}</h1>
            <p>{{ story_intro }}</p>
        </div>
    </section>

    <section class="sulmina-story-page__values">
        <div class="sulmina-story-page__grid sulmina-container">
            <article class="sulmina-story-page__card">
                <h2>{{ story_customer_title }}</h2>
                <p>{{ story_customer_text }}</p>
            </article>
            <article class="sulmina-story-page__card">
                <h2>{{ story_producer_title }}</h2>
                <p>{{ story_producer_text }}</p>
            </article>
        </div>
    </section>

    <section class="sulmina-story-page__cta">
        <div class="sulmina-container">
            <h2>{{ story_cta_title }}</h2>
            <a class="sulmina-button sulmina-button--gold" href="{{ story_cta_url }}">{{ story_cta_button }}</a>
        </div>
    </section>
</main>
