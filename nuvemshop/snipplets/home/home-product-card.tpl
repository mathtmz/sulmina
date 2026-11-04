{# Product data comes from Nuvemshop. Optional Sulmina filters use product tags. #}
{% set product_url_with_selected_variant = product.url %}
{% set image_classes = 'js-item-image lazyautosizes lazyload fade-in img-absolute img-absolute-centered' %}
{% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
{% set sulmina_roast = '' %}
{% set sulmina_notes = '' %}
{% set sulmina_producer = '' %}
{% set sulmina_grind = '' %}
{% set note_chocolate = false %}
{% set note_caramelo = false %}
{% set note_laranja = false %}
{% set note_floral = false %}
{% set note_nozes = false %}
{% set note_mel = false %}
{% set note_frutado = false %}

{# Compatibility for the three initial products until their tags are filled in the catalog. #}
{% if product.name == 'Café Terras Altas' %}
    {% set sulmina_roast = 'media' %}
    {% set sulmina_notes = 'chocolate caramelo' %}
    {% set sulmina_producer = 'joao-lucio' %}
    {% set sulmina_grind = 'moido' %}
    {% set note_chocolate = true %}
    {% set note_caramelo = true %}
{% elseif product.name == 'Café Serra da Mantiqueira' %}
    {% set sulmina_roast = 'media' %}
    {% set sulmina_notes = 'laranja floral' %}
    {% set sulmina_producer = 'familia-andrade' %}
    {% set sulmina_grind = 'moido' %}
    {% set note_laranja = true %}
    {% set note_floral = true %}
{% elseif product.name == 'Café Raízes de Machado' %}
    {% set sulmina_roast = 'media' %}
    {% set sulmina_notes = 'nozes mel' %}
    {% set sulmina_producer = 'dona-marta' %}
    {% set sulmina_grind = 'moido' %}
    {% set note_nozes = true %}
    {% set note_mel = true %}
{% endif %}

{# Recommended catalog tags: torra:media, nota:chocolate, produtor:joao-lucio, moagem:moido. #}
{% for tag in product.tags %}
    {% if tag == 'torra:clara' %}{% set sulmina_roast = 'clara' %}{% endif %}
    {% if tag == 'torra:media' %}{% set sulmina_roast = 'media' %}{% endif %}
    {% if tag == 'torra:escura' %}{% set sulmina_roast = 'escura' %}{% endif %}
    {% if tag == 'moagem:grao' %}{% set sulmina_grind = 'grao' %}{% endif %}
    {% if tag == 'moagem:moido' %}{% set sulmina_grind = 'moido' %}{% endif %}
    {% if tag == 'produtor:dona-marta' %}{% set sulmina_producer = 'dona-marta' %}{% endif %}
    {% if tag == 'produtor:joao-lucio' %}{% set sulmina_producer = 'joao-lucio' %}{% endif %}
    {% if tag == 'produtor:familia-andrade' %}{% set sulmina_producer = 'familia-andrade' %}{% endif %}
    {% if tag == 'nota:chocolate' %}{% set note_chocolate = true %}{% endif %}
    {% if tag == 'nota:caramelo' %}{% set note_caramelo = true %}{% endif %}
    {% if tag == 'nota:laranja' %}{% set note_laranja = true %}{% endif %}
    {% if tag == 'nota:floral' %}{% set note_floral = true %}{% endif %}
    {% if tag == 'nota:nozes' %}{% set note_nozes = true %}{% endif %}
    {% if tag == 'nota:mel' %}{% set note_mel = true %}{% endif %}
    {% if tag == 'nota:frutado' %}{% set note_frutado = true %}{% endif %}
{% endfor %}

{% set sulmina_notes = '' %}
{% if note_chocolate %}{% set sulmina_notes = sulmina_notes ~ ' chocolate' %}{% endif %}
{% if note_caramelo %}{% set sulmina_notes = sulmina_notes ~ ' caramelo' %}{% endif %}
{% if note_laranja %}{% set sulmina_notes = sulmina_notes ~ ' laranja' %}{% endif %}
{% if note_floral %}{% set sulmina_notes = sulmina_notes ~ ' floral' %}{% endif %}
{% if note_nozes %}{% set sulmina_notes = sulmina_notes ~ ' nozes' %}{% endif %}
{% if note_mel %}{% set sulmina_notes = sulmina_notes ~ ' mel' %}{% endif %}
{% if note_frutado %}{% set sulmina_notes = sulmina_notes ~ ' frutado' %}{% endif %}

<article class="sulmina-home-product-card js-product-container" data-product-id="{{ product.id }}" data-variants="{{ product.variants_object | json_encode }}" data-sulmina-roast="{{ sulmina_roast }}" data-sulmina-notes="{{ sulmina_notes }}" data-sulmina-producer="{{ sulmina_producer }}" data-sulmina-grind="{{ sulmina_grind }}" data-store="product-item-{{ product.id }}">
    <div class="sulmina-home-product-card__media">
        {{ component(
            'product-item-image', {
                image_lazy: true,
                image_lazy_js: true,
                image_data_expand: '-10',
                image_secondary_data_sizes: 'auto',
                secondary_image: false,
                slider: false,
                placeholder: true,
                image_priority_high: false,
                custom_content: '',
                slider_pagination_container: false,
                product_item_image_classes: {
                    image_container: 'item-image',
                    image_padding_container: 'js-item-image-padding position-relative d-block',
                    image: image_classes,
                    image_featured: 'item-image-featured',
                    image_secondary: 'item-image-secondary',
                    slider_container: 'swiper-container position-absolute h-100 w-100',
                    slider_wrapper: 'swiper-wrapper',
                    slider_slide: 'swiper-slide item-image-slide',
                    placeholder: 'placeholder-fade',
                },
            }
        ) }}
    </div>

    <div class="sulmina-home-product-card__info">
        <a class="sulmina-home-product-card__name js-product-name" href="{{ product_url_with_selected_variant }}">{{ product.name }}</a>

        {% if sulmina_producer == 'joao-lucio' %}<div class="sulmina-home-product-card__producer">de João Lúcio, Poço Fundo/MG</div>
        {% elseif sulmina_producer == 'familia-andrade' %}<div class="sulmina-home-product-card__producer">de Família Andrade, Carmo de Minas/MG</div>
        {% elseif sulmina_producer == 'dona-marta' %}<div class="sulmina-home-product-card__producer">de Dona Marta, Machado/MG</div>{% endif %}

        {% if sulmina_notes %}
            <div class="sulmina-home-product-card__tags">
                {% if note_chocolate %}<span>chocolate</span>{% endif %}
                {% if note_caramelo %}<span>caramelo</span>{% endif %}
                {% if note_laranja %}<span>laranja</span>{% endif %}
                {% if note_floral %}<span>floral</span>{% endif %}
                {% if note_nozes %}<span>nozes</span>{% endif %}
                {% if note_mel %}<span>mel</span>{% endif %}
                {% if note_frutado %}<span>frutado</span>{% endif %}
            </div>
        {% else %}
            <div class="sulmina-home-product-card__tags" aria-hidden="true"></div>
        {% endif %}

        <div class="sulmina-home-product-card__buy-row">
            {% if product.display_price %}
                <span class="sulmina-home-product-card__price js-price-display">{{ product.price | money }}</span>
            {% endif %}

            {% if state == 'cart' and not product.variations %}
                <form class="sulmina-home-product-card__form js-product-form" method="post" action="{{ store.cart_url }}">
                    <input type="hidden" name="add_to_cart" value="{{ product.id }}" />
                    <input type="hidden" class="js-quantity-input" value="1" />
                    <input type="submit" class="sulmina-home-product-card__button js-addtocart js-prod-submit-form {{ state }}" value="Adicionar" aria-label="Adicionar {{ product.name }} ao carrinho" data-component="product-list-item.add-to-cart" data-component-value="{{ product.id }}" />
                    {% include 'snipplets/placeholders/button-placeholder.tpl' with {direct_add: true} %}
                </form>
            {% else %}
                <a class="sulmina-home-product-card__button" href="{{ product_url_with_selected_variant }}">{% if state == 'nostock' %}Indisponível{% elseif state == 'contact' %}Consultar{% else %}Adicionar{% endif %}</a>
            {% endif %}
        </div>
    </div>
</article>
