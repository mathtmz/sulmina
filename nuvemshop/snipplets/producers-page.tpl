{% set producers_page_title = settings.producers_page_title | default('Quem faz o seu café') %}
{% set producers_page_description = settings.producers_page_description | default('Cada saca vem de uma propriedade, de uma família, de uma história. Aqui você não compra só café: conhece quem plantou.') %}
{% set producers_page_cta_title = settings.producers_page_cta_title | default('Você é produtor no Sul de Minas?') %}
{% set producers_page_cta_text = settings.producers_page_cta_text | default('Se você produz café especial na região e quer um canal de venda direta, fale com a gente.') %}
{% set producers_page_cta_button = settings.producers_page_cta_button | default('Fale conosco') %}
{% set producers_page_cta_url = settings.producers_page_cta_url | default('/contato/') %}

{% set producer_01_image = 'home_producer_01.jpg' | has_custom_image %}
{% set producer_02_image = 'home_producer_02.jpg' | has_custom_image %}
{% set producer_03_image = 'home_producer_03.jpg' | has_custom_image %}
{% set producer_04_image = 'home_producer_04.jpg' | has_custom_image %}

{% set producer_01_name = settings.home_producer_01_name | default('Dona Marta') %}
{% set producer_01_location = settings.home_producer_01_location | default('Machado / MG') %}
{% set producer_01_badge = settings.home_producer_01_badge | default('🏆 Prêmio Regional de Qualidade 2025') %}
{% set producer_01_bio = settings.home_producer_01_bio | default('Há mais de 20 anos cultivando café de altitude, Dona Marta transformou uma pequena produção familiar em referência de qualidade na região.') %}
{% set producer_01_link_text = settings.home_producer_01_link_text | default('Conhecer a história completa →') %}
{% set producer_01_link_url = settings.home_producer_01_link_url | default('') %}

{% set producer_02_name = settings.home_producer_02_name | default('João Lúcio') %}
{% set producer_02_location = settings.home_producer_02_location | default('Poço Fundo / MG') %}
{% set producer_02_badge = settings.home_producer_02_badge | default('🏆 Concurso de Qualidade — Sul de Minas') %}
{% set producer_02_bio = settings.home_producer_02_bio | default('Produtor de terceira geração, ele aposta em processos especiais de fermentação para trazer notas sensoriais únicas ao café.') %}
{% set producer_02_link_text = settings.home_producer_02_link_text | default('Conhecer a história completa →') %}
{% set producer_02_link_url = settings.home_producer_02_link_url | default('') %}

{% set producer_03_name = settings.home_producer_03_name | default('Família Andrade') %}
{% set producer_03_location = settings.home_producer_03_location | default('Carmo de Minas / MG') %}
{% set producer_03_badge = settings.home_producer_03_badge | default('🏆 Certificação de Origem') %}
{% set producer_03_bio = settings.home_producer_03_bio | default('Em Carmo de Minas, uma das regiões mais premiadas do Brasil, a família Andrade cultiva cafés florais e cítricos com vista para a Serra da Mantiqueira.') %}
{% set producer_03_link_text = settings.home_producer_03_link_text | default('Conhecer a história completa →') %}
{% set producer_03_link_url = settings.home_producer_03_link_url | default('') %}

{% set producer_04_name = settings.home_producer_04_name | default('Seu Antônio') %}
{% set producer_04_location = settings.home_producer_04_location | default('Alfenas / MG') %}
{% set producer_04_badge = settings.home_producer_04_badge | default('🏆 Selo de Qualidade EMATER-MG') %}
{% set producer_04_bio = settings.home_producer_04_bio | default('Com décadas de experiência, Seu Antônio é referência em processamento cuidadoso e secagem lenta, garantindo consistência de safra a safra.') %}
{% set producer_04_link_text = settings.home_producer_04_link_text | default('Conhecer a história completa →') %}
{% set producer_04_link_url = settings.home_producer_04_link_url | default('') %}

<main class="sulmina-producers-page" data-store="producers-page">
    <section class="sulmina-producers-page__hero">
        <div class="sulmina-container sulmina-producers-page__hero-inner">
            <h1>{{ producers_page_title }}</h1>
            <p>{{ producers_page_description }}</p>
        </div>
    </section>

    <section class="sulmina-producers-page__list">
        <div class="sulmina-container">
            <article class="sulmina-producer-story">
                {% if producer_01_image %}<img class="sulmina-producer-story__image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'home_producer_01.jpg' | static_url | settings_image_url('large') }}" alt="{{ producer_01_name }}">{% else %}<div class="sulmina-placeholder sulmina-producer-story__image">Foto de {{ producer_01_name }}</div>{% endif %}
                <div class="sulmina-producer-story__content">
                    <h2>{{ producer_01_name }}</h2>
                    <p class="sulmina-producer-story__location">{{ producer_01_location }}</p>
                    {% if producer_01_badge %}<span class="sulmina-producer-story__badge">{{ producer_01_badge }}</span>{% endif %}
                    <p>{{ producer_01_bio }}</p>
                    {% if producer_01_link_url %}<a class="sulmina-text-link" href="{{ producer_01_link_url }}">{{ producer_01_link_text }}</a>{% endif %}
                </div>
            </article>

            <article class="sulmina-producer-story">
                {% if producer_02_image %}<img class="sulmina-producer-story__image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'home_producer_02.jpg' | static_url | settings_image_url('large') }}" alt="{{ producer_02_name }}">{% else %}<div class="sulmina-placeholder sulmina-producer-story__image">Foto de {{ producer_02_name }}</div>{% endif %}
                <div class="sulmina-producer-story__content">
                    <h2>{{ producer_02_name }}</h2>
                    <p class="sulmina-producer-story__location">{{ producer_02_location }}</p>
                    {% if producer_02_badge %}<span class="sulmina-producer-story__badge">{{ producer_02_badge }}</span>{% endif %}
                    <p>{{ producer_02_bio }}</p>
                    {% if producer_02_link_url %}<a class="sulmina-text-link" href="{{ producer_02_link_url }}">{{ producer_02_link_text }}</a>{% endif %}
                </div>
            </article>

            <article class="sulmina-producer-story">
                {% if producer_03_image %}<img class="sulmina-producer-story__image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'home_producer_03.jpg' | static_url | settings_image_url('large') }}" alt="{{ producer_03_name }}">{% else %}<div class="sulmina-placeholder sulmina-producer-story__image">Foto de {{ producer_03_name }}</div>{% endif %}
                <div class="sulmina-producer-story__content">
                    <h2>{{ producer_03_name }}</h2>
                    <p class="sulmina-producer-story__location">{{ producer_03_location }}</p>
                    {% if producer_03_badge %}<span class="sulmina-producer-story__badge">{{ producer_03_badge }}</span>{% endif %}
                    <p>{{ producer_03_bio }}</p>
                    {% if producer_03_link_url %}<a class="sulmina-text-link" href="{{ producer_03_link_url }}">{{ producer_03_link_text }}</a>{% endif %}
                </div>
            </article>

            <article class="sulmina-producer-story">
                {% if producer_04_image %}<img class="sulmina-producer-story__image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'home_producer_04.jpg' | static_url | settings_image_url('large') }}" alt="{{ producer_04_name }}">{% else %}<div class="sulmina-placeholder sulmina-producer-story__image">Foto de {{ producer_04_name }}</div>{% endif %}
                <div class="sulmina-producer-story__content">
                    <h2>{{ producer_04_name }}</h2>
                    <p class="sulmina-producer-story__location">{{ producer_04_location }}</p>
                    {% if producer_04_badge %}<span class="sulmina-producer-story__badge">{{ producer_04_badge }}</span>{% endif %}
                    <p>{{ producer_04_bio }}</p>
                    {% if producer_04_link_url %}<a class="sulmina-text-link" href="{{ producer_04_link_url }}">{{ producer_04_link_text }}</a>{% endif %}
                </div>
            </article>
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
