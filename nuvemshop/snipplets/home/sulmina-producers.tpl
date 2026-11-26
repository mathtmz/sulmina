{% set home_producers_title = settings.home_producers_title | default('Quem faz o seu café') %}
{% set home_producers_description = settings.home_producers_description | default('Cada saca vem de uma propriedade, de uma família, de uma história. Aqui você não compra só café: conhece quem plantou.') %}
{% set home_producers_link_text = settings.home_producers_link_text | default('Conhecer todos os produtores →') %}
{% set home_producers_link_url = settings.home_producers_link_url | default('/produtores/') %}
{% if home_producers_link_url == '/paginas/produtores/' %}{% set home_producers_link_url = '/produtores/' %}{% endif %}

{% set sulmina_producers = [
    {'slug': settings.home_producer_01_slug | default('doceira-coffees'), 'name': settings.home_producer_01_name, 'location': settings.home_producer_01_location, 'quote': settings.home_producer_01_quote, 'image': 'home_producer_01.jpg'},
    {'slug': settings.home_producer_02_slug | default('grao-bao'), 'name': settings.home_producer_02_name, 'location': settings.home_producer_02_location, 'quote': settings.home_producer_02_quote, 'image': 'home_producer_02.jpg'},
    {'slug': settings.home_producer_03_slug | default('coopfam'), 'name': settings.home_producer_03_name, 'location': settings.home_producer_03_location, 'quote': settings.home_producer_03_quote, 'image': 'home_producer_03.jpg'},
    {'slug': settings.home_producer_04_slug, 'name': settings.home_producer_04_name, 'location': settings.home_producer_04_location, 'quote': settings.home_producer_04_quote, 'image': 'home_producer_04.jpg'},
    {'slug': settings.home_producer_05_slug, 'name': settings.home_producer_05_name, 'location': settings.home_producer_05_location, 'quote': settings.home_producer_05_quote, 'image': 'home_producer_05.jpg'},
    {'slug': settings.home_producer_06_slug, 'name': settings.home_producer_06_name, 'location': settings.home_producer_06_location, 'quote': settings.home_producer_06_quote, 'image': 'home_producer_06.jpg'},
    {'slug': settings.home_producer_07_slug, 'name': settings.home_producer_07_name, 'location': settings.home_producer_07_location, 'quote': settings.home_producer_07_quote, 'image': 'home_producer_07.jpg'},
    {'slug': settings.home_producer_08_slug, 'name': settings.home_producer_08_name, 'location': settings.home_producer_08_location, 'quote': settings.home_producer_08_quote, 'image': 'home_producer_08.jpg'}
] %}

<section class="sulmina-producers" id="sulmina-produtores" data-store="home-producers">
    <div class="sulmina-container">
        <div class="sulmina-section-heading sulmina-section-heading--center">
            <h2>{{ home_producers_title }}</h2>
            <p>{{ home_producers_description }}</p>
        </div>
        <div class="sulmina-producer-grid">
            {% for producer in sulmina_producers %}
                {% if producer.name %}
                    <article class="sulmina-producer-card" data-producer-slug="{{ producer.slug }}">
                        {% if producer.image | has_custom_image %}
                            <img class="sulmina-producer-card__image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ producer.image | static_url | settings_image_url('small') }}" alt="{{ producer.name }}">
                        {% else %}
                            <div class="sulmina-placeholder sulmina-placeholder--round" aria-hidden="true">Foto do produtor</div>
                        {% endif %}
                        <h3>{{ producer.name }}</h3>
                        {% if producer.location %}<span>{{ producer.location }}</span>{% endif %}
                        {% if producer.quote %}<p>{{ producer.quote }}</p>{% endif %}
                    </article>
                {% endif %}
            {% endfor %}
        </div>
        <p class="sulmina-centered"><a class="sulmina-text-link" href="{{ home_producers_link_url }}">{{ home_producers_link_text }}</a></p>
    </div>
</section>
