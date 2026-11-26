{% set producers_page_title = settings.producers_page_title | default('Quem faz o seu café') %}
{% set producers_page_description = settings.producers_page_description | default('Cada saca vem de uma propriedade, de uma família, de uma história. Aqui você não compra só café: conhece quem plantou.') %}
{% set producers_page_cta_title = settings.producers_page_cta_title | default('Você é produtor no Sul de Minas?') %}
{% set producers_page_cta_text = settings.producers_page_cta_text | default('Se você produz café especial na região e quer um canal de venda direta, fale com a gente.') %}
{% set producers_page_cta_button = settings.producers_page_cta_button | default('Fale conosco') %}
{% set producers_page_cta_url = settings.producers_page_cta_url | default('/contato/') %}

{% set sulmina_producers = [
    {'slug': settings.home_producer_01_slug | default('doceira-coffees'), 'name': settings.home_producer_01_name, 'location': settings.home_producer_01_location, 'badge': settings.home_producer_01_badge, 'bio': settings.home_producer_01_bio, 'link_text': settings.home_producer_01_link_text, 'link_url': settings.home_producer_01_link_url, 'image': 'home_producer_01.jpg', 'cover': 'home_producer_01_cover.jpg'},
    {'slug': settings.home_producer_02_slug | default('grao-bao'), 'name': settings.home_producer_02_name, 'location': settings.home_producer_02_location, 'badge': settings.home_producer_02_badge, 'bio': settings.home_producer_02_bio, 'link_text': settings.home_producer_02_link_text, 'link_url': settings.home_producer_02_link_url, 'image': 'home_producer_02.jpg', 'cover': 'home_producer_02_cover.jpg'},
    {'slug': settings.home_producer_03_slug | default('coopfam'), 'name': settings.home_producer_03_name, 'location': settings.home_producer_03_location, 'badge': settings.home_producer_03_badge, 'bio': settings.home_producer_03_bio, 'link_text': settings.home_producer_03_link_text, 'link_url': settings.home_producer_03_link_url, 'image': 'home_producer_03.jpg', 'cover': 'home_producer_03_cover.jpg'},
    {'slug': settings.home_producer_04_slug, 'name': settings.home_producer_04_name, 'location': settings.home_producer_04_location, 'badge': settings.home_producer_04_badge, 'bio': settings.home_producer_04_bio, 'link_text': settings.home_producer_04_link_text, 'link_url': settings.home_producer_04_link_url, 'image': 'home_producer_04.jpg', 'cover': 'home_producer_04_cover.jpg'},
    {'slug': settings.home_producer_05_slug, 'name': settings.home_producer_05_name, 'location': settings.home_producer_05_location, 'badge': settings.home_producer_05_badge, 'bio': settings.home_producer_05_bio, 'link_text': settings.home_producer_05_link_text, 'link_url': settings.home_producer_05_link_url, 'image': 'home_producer_05.jpg', 'cover': 'home_producer_05_cover.jpg'},
    {'slug': settings.home_producer_06_slug, 'name': settings.home_producer_06_name, 'location': settings.home_producer_06_location, 'badge': settings.home_producer_06_badge, 'bio': settings.home_producer_06_bio, 'link_text': settings.home_producer_06_link_text, 'link_url': settings.home_producer_06_link_url, 'image': 'home_producer_06.jpg', 'cover': 'home_producer_06_cover.jpg'},
    {'slug': settings.home_producer_07_slug, 'name': settings.home_producer_07_name, 'location': settings.home_producer_07_location, 'badge': settings.home_producer_07_badge, 'bio': settings.home_producer_07_bio, 'link_text': settings.home_producer_07_link_text, 'link_url': settings.home_producer_07_link_url, 'image': 'home_producer_07.jpg', 'cover': 'home_producer_07_cover.jpg'},
    {'slug': settings.home_producer_08_slug, 'name': settings.home_producer_08_name, 'location': settings.home_producer_08_location, 'badge': settings.home_producer_08_badge, 'bio': settings.home_producer_08_bio, 'link_text': settings.home_producer_08_link_text, 'link_url': settings.home_producer_08_link_url, 'image': 'home_producer_08.jpg', 'cover': 'home_producer_08_cover.jpg'}
] %}

<main class="sulmina-producers-page" data-store="producers-page">
    <section class="sulmina-producers-page__hero">
        <div class="sulmina-container sulmina-producers-page__hero-inner">
            <h1>{{ producers_page_title }}</h1>
            <p>{{ producers_page_description }}</p>
        </div>
    </section>

    <section class="sulmina-producers-page__list">
        <div class="sulmina-container">
            {% for producer in sulmina_producers %}
                {% if producer.name %}
                    {% set has_cover = producer.cover | has_custom_image %}
                    {% set has_logo = producer.image | has_custom_image %}
                    <article class="sulmina-producer-story" data-producer-slug="{{ producer.slug }}">
                        {% if has_cover %}
                            <img class="sulmina-producer-story__image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ producer.cover | static_url | settings_image_url('large') }}" alt="Foto de {{ producer.name }}">
                        {% elseif has_logo %}
                            <img class="sulmina-producer-story__image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ producer.image | static_url | settings_image_url('large') }}" alt="Logo de {{ producer.name }}">
                        {% else %}
                            <div class="sulmina-placeholder sulmina-producer-story__image">Foto de {{ producer.name }}</div>
                        {% endif %}
                        <div class="sulmina-producer-story__content">
                            <h2>{{ producer.name }}</h2>
                            {% if producer.location %}<p class="sulmina-producer-story__location">{{ producer.location }}</p>{% endif %}
                            {% if producer.badge %}<span class="sulmina-producer-story__badge">{{ producer.badge }}</span>{% endif %}
                            {% if producer.bio %}<p>{{ producer.bio }}</p>{% endif %}
                            {% if producer.link_url %}<a class="sulmina-text-link" href="{{ producer.link_url }}">{{ producer.link_text | default('Conhecer a história completa →') }}</a>{% endif %}
                        </div>
                    </article>
                {% endif %}
            {% endfor %}
        </div>
    </section>

    <section class="sulmina-producers-page__cta">
        <div class="sulmina-container sulmina-producers-page__cta-inner">
            <h2>{{ producers_page_cta_title }}</h2>
            <p>{{ producers_page_cta_text }}</p>
            <a class="sulmina-button sulmina-button--gold" href="{{ producers_page_cta_url }}">{{ producers_page_cta_button }}</a>
        </div>
    </section>
</main>
