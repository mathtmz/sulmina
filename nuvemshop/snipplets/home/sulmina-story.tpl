{% set home_story_title = settings.home_story_title | default('De volta pra casa') %}
{% set home_story_text = settings.home_story_text | default('“Somos do Sul de Minas. Moramos fora — São Paulo, Bahia — e sentimos na pele a falta de um café que fosse de verdade da nossa terra...”') %}
{% set home_story_link_text = settings.home_story_link_text | default('Leia nossa história completa →') %}
{% set home_story_link_url = settings.home_story_link_url | default('/nossa-historia') %}
{% if 'paginas/historia' in (home_story_link_url | lower) %}
    {% set home_story_link_url = '/nossa-historia' %}
{% endif %}
{% set home_story_image = 'home_story_image.jpg' | has_custom_image %}
<section class="sulmina-story sulmina-story--feature" id="sulmina-origem" data-store="home-story">
    <div class="sulmina-container sulmina-story__grid">
        {% if home_story_image %}<img class="sulmina-story__image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'home_story_image.jpg' | static_url | settings_image_url('large') }}" alt="{{ home_story_title }}">{% else %}<div class="sulmina-placeholder sulmina-placeholder--wide">Foto dos fundadores / paisagem da Serra</div>{% endif %}
        <div class="sulmina-story__text"><h2>{{ home_story_title }}</h2><p>{{ home_story_text }}</p><a class="sulmina-text-link" href="{{ home_story_link_url }}">{{ home_story_link_text }}</a></div>
    </div>
</section>
