{% set page_name = page.name | default('') | lower %}
{% set page_url = page.url | default('') | lower %}
{% set is_newsletter_page = ('newsletter' in page_name) or ('newsletter' in page_url) %}
{% set is_producers_page = ('produtor' in page_name) or ('produtor' in page_url) %}
{% set is_story_page = ('hist' in page_name) or ('hist' in page_url) %}
{% set is_faq_page = ('frequ' in page_name) or ('frequ' in page_url) or ('faq' in page_name) or ('faq' in page_url) %}
{% set is_privacy_page = ('privacidade' in page_name) or ('privacidade' in page_url) %}
{% set is_terms_page = ('termo' in page_name) or ('termo' in page_url) %}
{% set is_returns_page = ('troca' in page_name) or ('troca' in page_url) or ('devolu' in page_name) or ('devolu' in page_url) %}
{% set is_help_page = is_faq_page or is_privacy_page or is_terms_page or is_returns_page %}

{% if is_newsletter_page %}
    {% include 'snipplets/newsletter-page.tpl' %}
{% elseif is_producers_page %}
    {% include 'snipplets/producers-page.tpl' %}
{% elseif is_story_page %}
    {% include 'snipplets/story-page.tpl' %}
{% else %}
    {% if is_help_page %}
        <main class="sulmina-help-page {% if is_faq_page %}sulmina-help-page--faq{% elseif is_privacy_page %}sulmina-help-page--privacy{% elseif is_terms_page %}sulmina-help-page--terms{% elseif is_returns_page %}sulmina-help-page--returns{% endif %}">
            <section class="sulmina-help-page__hero" aria-labelledby="sulmina-help-page-title">
                <div class="sulmina-help-page__hero-inner">
                    <p class="sulmina-help-page__eyebrow">Ajuda Sulmina</p>
                    <h1 id="sulmina-help-page-title">{{ page.name }}</h1>
                    <span class="sulmina-help-page__hero-line" aria-hidden="true"></span>
                </div>
            </section>

            {# Content remains fully editable from Nuvemshop Pages. #}
            <section class="sulmina-help-page__body user-content">
                <div class="container">
                    <article class="sulmina-help-page__content sulmina-rich-content">
                        {{ page.content }}
                    </article>
                </div>
            </section>
        </main>
    {% else %}
        <main class="sulmina-editorial-page">
        {% embed "snipplets/page-header.tpl" %}
            {% block page_header_text %}{{ page.name }}{% endblock page_header_text %}
        {% endembed %}

        {# Institutional page content remains managed from Nuvemshop Pages. #}
        <section class="sulmina-editorial-page__body user-content pb-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-8 sulmina-rich-content">
                        {{ page.content }}
                    </div>
                </div>
            </div>
        </section>
        </main>
    {% endif %}
{% endif %}
