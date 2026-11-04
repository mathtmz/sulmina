<main class="sulmina-category-page sulmina-loja-page">
{% set loja_title = settings.loja_title | default('Nossos cafés') %}
{% set loja_description = settings.loja_description | default('Café especial, embalado com carinho, direto dos produtores do Sul de Minas.') %}
{% set loja_banner_text = settings.loja_banner_text | default('Embalado com carinho e enviado pra qualquer lugar do Brasil.') %}
{% set loja_banner_button = settings.loja_banner_button | default('Conhecer os produtores') %}
{% set loja_banner_url = settings.loja_banner_url | default('/produtores/') %}
{% if loja_banner_url == '/paginas/produtores/' %}{% set loja_banner_url = '/produtores/' %}{% endif %}
{% set has_filters_available = products and has_filters_enabled and (filter_categories is not empty or product_filters is not empty) %}

{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}

{% if settings.pagination == 'infinite' %}
	{% paginate by 12 %}
{% else %}
	{% paginate by 24 %}
{% endif %}

{% if not show_help %}

{% include 'snipplets/loja/loja-hero.tpl' %}

<section class="sulmina-loja-body" data-store="category-grid-{{ category.id }}">
	<div class="sulmina-container sulmina-loja-layout">
		{% include 'snipplets/loja/loja-filters.tpl' %}
		{% include 'snipplets/loja/loja-products.tpl' %}
	</div>
</section>
{% elseif show_help %}
	{# Category Placeholder #}
	{% include 'snipplets/defaults/show_help_category.tpl' %}
{% endif %}
</main>
