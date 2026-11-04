{% set home_producers_title = settings.home_producers_title | default('Quem faz o seu café') %}
{% set home_producers_description = settings.home_producers_description | default('Cada saca vem de uma propriedade, de uma família, de uma história. Aqui você não compra só café: conhece quem plantou.') %}
{% set home_producers_link_text = settings.home_producers_link_text | default('Conhecer todos os produtores →') %}
{% set home_producers_link_url = settings.home_producers_link_url | default('/produtores/') %}
{% if home_producers_link_url == '/paginas/produtores/' %}{% set home_producers_link_url = '/produtores/' %}{% endif %}
{% set producer_01_image = 'home_producer_01.jpg' | has_custom_image %}
{% set producer_02_image = 'home_producer_02.jpg' | has_custom_image %}
{% set producer_03_image = 'home_producer_03.jpg' | has_custom_image %}
{% set producer_04_image = 'home_producer_04.jpg' | has_custom_image %}

<section class="sulmina-producers" id="sulmina-produtores" data-store="home-producers">
    <div class="sulmina-container">
        <div class="sulmina-section-heading sulmina-section-heading--center">
            <h2>{{ home_producers_title }}</h2>
            <p>{{ home_producers_description }}</p>
        </div>
        <div class="sulmina-producer-grid">
            <article class="sulmina-producer-card">
                {% if producer_01_image %}<img class="sulmina-producer-card__image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'home_producer_01.jpg' | static_url | settings_image_url('small') }}" alt="{{ settings.home_producer_01_name | default('Dona Marta') }}">{% else %}<div class="sulmina-placeholder sulmina-placeholder--round">Foto do produtor</div>{% endif %}
                <h3>{{ settings.home_producer_01_name | default('Dona Marta') }}</h3><span>{{ settings.home_producer_01_location | default('Machado / MG') }}</span><p>{{ settings.home_producer_01_quote | default('“Café é o que a gente mais orgulha de fazer aqui em casa.”') }}</p>
            </article>
            <article class="sulmina-producer-card">
                {% if producer_02_image %}<img class="sulmina-producer-card__image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'home_producer_02.jpg' | static_url | settings_image_url('small') }}" alt="{{ settings.home_producer_02_name | default('João Lúcio') }}">{% else %}<div class="sulmina-placeholder sulmina-placeholder--round">Foto do produtor</div>{% endif %}
                <h3>{{ settings.home_producer_02_name | default('João Lúcio') }}</h3><span>{{ settings.home_producer_02_location | default('Poço Fundo / MG') }}</span><p>{{ settings.home_producer_02_quote | default('“Cada grão carrega o cuidado de três gerações.”') }}</p>
            </article>
            <article class="sulmina-producer-card">
                {% if producer_03_image %}<img class="sulmina-producer-card__image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'home_producer_03.jpg' | static_url | settings_image_url('small') }}" alt="{{ settings.home_producer_03_name | default('Família Andrade') }}">{% else %}<div class="sulmina-placeholder sulmina-placeholder--round">Foto do produtor</div>{% endif %}
                <h3>{{ settings.home_producer_03_name | default('Família Andrade') }}</h3><span>{{ settings.home_producer_03_location | default('Carmo de Minas / MG') }}</span><p>{{ settings.home_producer_03_quote | default('“A gente planta olhando pra serra todo santo dia.”') }}</p>
            </article>
            <article class="sulmina-producer-card">
                {% if producer_04_image %}<img class="sulmina-producer-card__image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'home_producer_04.jpg' | static_url | settings_image_url('small') }}" alt="{{ settings.home_producer_04_name | default('Seu Antônio') }}">{% else %}<div class="sulmina-placeholder sulmina-placeholder--round">Foto do produtor</div>{% endif %}
                <h3>{{ settings.home_producer_04_name | default('Seu Antônio') }}</h3><span>{{ settings.home_producer_04_location | default('Alfenas / MG') }}</span><p>{{ settings.home_producer_04_quote | default('“Café bom se faz com paciência, não com pressa.”') }}</p>
            </article>
        </div>
        <p class="sulmina-centered"><a class="sulmina-text-link" href="{{ home_producers_link_url }}">{{ home_producers_link_text }}</a></p>
    </div>
</section>
