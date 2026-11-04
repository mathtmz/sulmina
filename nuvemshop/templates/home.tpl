{# Sulmina home: each visual block lives in its own editor-ready module. #}
{% if settings.prelaunch_enabled %}
    {% include 'snipplets/home/prelaunch.tpl' %}
{% else %}
    <main class="sulmina-home">
        {% include 'snipplets/home/sulmina-hero.tpl' %}
        {% include 'snipplets/home/sulmina-trust.tpl' %}
        {% include 'snipplets/home/sulmina-producers.tpl' %}
        {% include 'snipplets/home/sulmina-products.tpl' %}
        {% include 'snipplets/home/sulmina-process.tpl' %}
        {% include 'snipplets/home/sulmina-story.tpl' %}
    </main>
{% endif %}
