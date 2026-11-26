{# Product data comes from Nuvemshop. Optional Sulmina filters use product tags. #}
{% set product_url_with_selected_variant = product.url %}
{% set image_classes = 'js-item-image lazyautosizes lazyload fade-in img-absolute img-absolute-centered' %}
{% set sulmina_has_discount = product.compare_at_price and product.compare_at_price > product.price %}
{% if sulmina_has_discount %}
    {% set sulmina_discount_percentage = ((product.compare_at_price - product.price) * 100 / product.compare_at_price) | round %}
{% endif %}
{% set use_default_grain_image = product.id in [368567848, 377417634, 377419250] %}
{% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
{% set sulmina_roast = '' %}
{% set sulmina_notes = '' %}
{% set sulmina_producer = '' %}
{% set sulmina_producer_name = '' %}
{% set sulmina_producer_location = '' %}
{% set sulmina_origin = '' %}
{% set sulmina_grind = '' %}
{% set note_chocolate = false %}
{% set note_caramelo = false %}
{% set note_laranja = false %}
{% set note_citrico = false %}
{% set note_floral = false %}
{% set note_nozes = false %}
{% set note_mel = false %}
{% set note_frutado = false %}
{% set note_manga = false %}
{% set note_frutas_vermelhas = false %}

{# Compatibility for the three initial products until their tags are filled in the catalog. #}
{% if product.name == 'Café Terras Altas' %}
    {% set sulmina_roast = 'media' %}
    {% set sulmina_notes = 'chocolate caramelo' %}
    {% set sulmina_grind = 'moido' %}
    {% set note_chocolate = true %}
    {% set note_caramelo = true %}
{% elseif product.name == 'Café Serra da Mantiqueira' %}
    {% set sulmina_roast = 'media' %}
    {% set sulmina_notes = 'laranja floral' %}
    {% set sulmina_grind = 'moido' %}
    {% set note_laranja = true %}
    {% set note_floral = true %}
{% elseif product.name == 'Café Raízes de Machado' %}
    {% set sulmina_roast = 'media' %}
    {% set sulmina_notes = 'nozes mel' %}
    {% set sulmina_grind = 'moido' %}
    {% set note_nozes = true %}
    {% set note_mel = true %}
{% elseif product.name == 'Café Doceira Coffees | Cítricos e Laranja' %}
    {% set sulmina_roast = 'media' %}
    {% set sulmina_origin = 'Campos Gerais/MG' %}
    {% set sulmina_grind = 'grao' %}
    {% set note_citrico = true %}
    {% set note_laranja = true %}
    {% set note_frutado = true %}
{% elseif product.name == 'Café Doceira Coffees | Caramelo e Chocolate' %}
    {% set sulmina_roast = 'media' %}
    {% set sulmina_origin = 'Campos Gerais/MG' %}
    {% set sulmina_grind = 'grao' %}
    {% set note_caramelo = true %}
    {% set note_chocolate = true %}
{% elseif product.name == 'Café Doceira Coffees | Manga e Frutas Vermelhas' %}
    {% set sulmina_roast = 'media' %}
    {% set sulmina_origin = 'Campos Gerais/MG' %}
    {% set sulmina_grind = 'grao' %}
    {% set note_manga = true %}
    {% set note_frutas_vermelhas = true %}
    {% set note_frutado = true %}
{% endif %}

{% set sulmina_producer_registry = [
    {'slug': settings.home_producer_01_slug | default('doceira-coffees'), 'name': settings.home_producer_01_name, 'location': settings.home_producer_01_location},
    {'slug': settings.home_producer_02_slug | default('grao-bao'), 'name': settings.home_producer_02_name, 'location': settings.home_producer_02_location},
    {'slug': settings.home_producer_03_slug | default('coopfam'), 'name': settings.home_producer_03_name, 'location': settings.home_producer_03_location},
    {'slug': settings.home_producer_04_slug, 'name': settings.home_producer_04_name, 'location': settings.home_producer_04_location},
    {'slug': settings.home_producer_05_slug, 'name': settings.home_producer_05_name, 'location': settings.home_producer_05_location},
    {'slug': settings.home_producer_06_slug, 'name': settings.home_producer_06_name, 'location': settings.home_producer_06_location},
    {'slug': settings.home_producer_07_slug, 'name': settings.home_producer_07_name, 'location': settings.home_producer_07_location},
    {'slug': settings.home_producer_08_slug, 'name': settings.home_producer_08_name, 'location': settings.home_producer_08_location}
] %}

{# Recommended tags include produtor:<slug>, with each slug configured in the shared producer registry. #}
{% for tag in product.tags %}
    {% if tag == 'torra:clara' %}{% set sulmina_roast = 'clara' %}{% endif %}
    {% if tag == 'torra:media' %}{% set sulmina_roast = 'media' %}{% endif %}
    {% if tag == 'torra:escura' %}{% set sulmina_roast = 'escura' %}{% endif %}
    {% if tag == 'moagem:grao' %}{% set sulmina_grind = 'grao' %}{% endif %}
    {% if tag == 'moagem:moido' %}{% set sulmina_grind = 'moido' %}{% endif %}
    {% for producer in sulmina_producer_registry %}
        {% if producer.slug and producer.name and tag == 'produtor:' ~ producer.slug %}
            {% set sulmina_producer = producer.slug %}
            {% set sulmina_producer_name = producer.name %}
            {% set sulmina_producer_location = producer.location %}
        {% endif %}
    {% endfor %}
    {% if tag == 'nota:chocolate' %}{% set note_chocolate = true %}{% endif %}
    {% if tag == 'nota:caramelo' %}{% set note_caramelo = true %}{% endif %}
    {% if tag == 'nota:laranja' %}{% set note_laranja = true %}{% endif %}
    {% if tag == 'nota:citrico' %}{% set note_citrico = true %}{% endif %}
    {% if tag == 'nota:floral' %}{% set note_floral = true %}{% endif %}
    {% if tag == 'nota:nozes' %}{% set note_nozes = true %}{% endif %}
    {% if tag == 'nota:mel' %}{% set note_mel = true %}{% endif %}
    {% if tag == 'nota:frutado' %}{% set note_frutado = true %}{% endif %}
    {% if tag == 'nota:manga' %}{% set note_manga = true %}{% endif %}
    {% if tag == 'nota:frutas-vermelhas' %}{% set note_frutas_vermelhas = true %}{% endif %}
{% endfor %}

{% set sulmina_notes = '' %}
{% if note_chocolate %}{% set sulmina_notes = sulmina_notes ~ ' chocolate' %}{% endif %}
{% if note_caramelo %}{% set sulmina_notes = sulmina_notes ~ ' caramelo' %}{% endif %}
{% if note_laranja %}{% set sulmina_notes = sulmina_notes ~ ' laranja' %}{% endif %}
{% if note_citrico %}{% set sulmina_notes = sulmina_notes ~ ' cítrico' %}{% endif %}
{% if note_floral %}{% set sulmina_notes = sulmina_notes ~ ' floral' %}{% endif %}
{% if note_nozes %}{% set sulmina_notes = sulmina_notes ~ ' nozes' %}{% endif %}
{% if note_mel %}{% set sulmina_notes = sulmina_notes ~ ' mel' %}{% endif %}
{% if note_frutado %}{% set sulmina_notes = sulmina_notes ~ ' frutado' %}{% endif %}
{% if note_manga %}{% set sulmina_notes = sulmina_notes ~ ' manga' %}{% endif %}
{% if note_frutas_vermelhas %}{% set sulmina_notes = sulmina_notes ~ ' frutas vermelhas' %}{% endif %}

<article class="sulmina-home-product-card js-product-container" data-product-id="{{ product.id }}" data-card-description="{{ product.description | json_encode | escape }}" data-card-tags="{{ product.tags | json_encode | escape }}" data-variants="{{ product.variants_object | json_encode }}" data-sulmina-roast="{{ sulmina_roast }}" data-sulmina-notes="{{ sulmina_notes }}" data-sulmina-producer="{{ sulmina_producer }}" data-sulmina-producer-label="{{ sulmina_producer_name }}" data-sulmina-producer-location="{{ sulmina_producer_location }}" data-sulmina-origin="{{ sulmina_origin }}" data-sulmina-grind="{{ sulmina_grind }}" data-store="product-item-{{ product.id }}">
    <div class="sulmina-home-product-card__media">
        {% if use_default_grain_image %}
            <div class="js-product-item-image-container-private product-item-image-container item-image" data-store="product-item-image-{{ product.id }}">
                {% for media in product.media %}
                    {% if loop.index0 == 1 and media.isImage %}
                        <div class="js-item-image-padding position-relative d-block" style="padding-bottom: {{ media.dimensions['height'] / media.dimensions['width'] * 100 }}%;">
                            <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" aria-label="{{ product.name }}" class="js-product-item-image-link-private">
                                <img width="{{ media.dimensions['width'] }}" height="{{ media.dimensions['height'] }}" src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset="{{ media | product_image_url('large') }} 480w, {{ media | product_image_url('huge') }} 640w, {{ media | product_image_url('original') }} 1024w" data-sizes="auto" class="{{ image_classes }} item-image-featured" alt="{{ product.name }}">
                            </a>
                        </div>
                    {% endif %}
                {% endfor %}
            </div>
        {% else %}
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
        {% endif %}
    </div>

    <div class="sulmina-home-product-card__info">
        <a class="sulmina-home-product-card__name js-product-name" href="{{ product_url_with_selected_variant }}">{{ product.name }}</a>

        {% if sulmina_producer_name %}<div class="sulmina-home-product-card__producer">de {{ sulmina_producer_name }}{% if sulmina_origin %} · {{ sulmina_origin }}{% elseif sulmina_producer_location %}, {{ sulmina_producer_location }}{% endif %}{% if sulmina_roast == 'media' %} · Torra média{% elseif sulmina_roast == 'clara' %} · Torra clara{% elseif sulmina_roast == 'escura' %} · Torra escura{% endif %}</div>
        {% elseif sulmina_origin %}<div class="sulmina-home-product-card__producer">{{ sulmina_origin }}{% if sulmina_roast == 'media' %} · Torra média{% elseif sulmina_roast == 'clara' %} · Torra clara{% elseif sulmina_roast == 'escura' %} · Torra escura{% endif %}</div>{% endif %}

        {% if sulmina_notes %}
            <div class="sulmina-home-product-card__tags">
                {% if note_chocolate %}<span>chocolate</span>{% endif %}
                {% if note_caramelo %}<span>caramelo</span>{% endif %}
                {% if note_laranja %}<span>laranja</span>{% endif %}
                {% if note_citrico %}<span>cítrico</span>{% endif %}
                {% if note_floral %}<span>floral</span>{% endif %}
                {% if note_nozes %}<span>nozes</span>{% endif %}
                {% if note_mel %}<span>mel</span>{% endif %}
                {% if note_frutado %}<span>frutado</span>{% endif %}
                {% if note_manga %}<span>manga</span>{% endif %}
                {% if note_frutas_vermelhas %}<span>frutas vermelhas</span>{% endif %}
            </div>
        {% else %}
            <div class="sulmina-home-product-card__tags" aria-hidden="true"></div>
        {% endif %}

        <div class="sulmina-home-product-card__buy-row">
            {% if product.display_price %}
                <div class="sulmina-home-product-card__price-group" data-store="product-item-price-{{ product.id }}">
                    {% if sulmina_has_discount %}
                        <span class="sulmina-home-product-card__price-compare js-compare-price-display price-compare" aria-label="Preço original">{{ product.compare_at_price | money }}</span>
                    {% endif %}
                    <span class="sulmina-home-product-card__price-current">
                        <span class="sulmina-home-product-card__price js-price-display" data-product-price="{{ product.price }}">{{ product.price | money }}</span>
                        {% if sulmina_has_discount %}
                            <span class="sulmina-home-product-card__discount" aria-label="Desconto de {{ sulmina_discount_percentage }} por cento">-{{ sulmina_discount_percentage }}%</span>
                        {% endif %}
                    </span>
                </div>
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

<script>
(function (script) {
    'use strict';
    var card = script.previousElementSibling;
    if (!card || !card.classList.contains('sulmina-home-product-card')) return;
    try {
        var description = JSON.parse(card.getAttribute('data-card-description') || 'null') || '';
        var tags = JSON.parse(card.getAttribute('data-card-tags') || '[]') || [];
        if (typeof description !== 'string' || !Array.isArray(tags)) return;
        var markup = description.replace(/<br\s*\/?>/gi, '\n').replace(/<\/p\s*>/gi, '\n').replace(/<\/div\s*>/gi, '\n');
        var text = new DOMParser().parseFromString(markup, 'text/html').body.textContent || '';
        var originMatch = text.match(/Origem:\s*([^\n]+)/i);
        var origin = originMatch ? originMatch[1].replace(/\s+/g, ' ').trim() : '';
        if (origin.length > 100) origin = '';
        var normalizedTags = tags.map(function (tag) { return typeof tag === 'string' ? tag : (tag && tag.attributes && tag.attributes.tag); }).filter(function (tag) { return typeof tag === 'string'; });
        card.removeAttribute('data-card-tags');
        card.removeAttribute('data-card-description');
        var explicitOrigin = normalizedTags.find(function (tag) { return /^origem:/i.test(tag); });
        if (explicitOrigin) origin = explicitOrigin.slice(explicitOrigin.indexOf(':') + 1).trim();
        var roastTag = normalizedTags.find(function (tag) { return /^torra:/i.test(tag); });
        var roastText = roastTag ? roastTag.slice(roastTag.indexOf(':') + 1) : text + ' ' + normalizedTags.join(' ');
        var roastMatch = roastText.match(/(?:torra[:\s-]*)?(média|media|clara|escura)/i);
        var roast = roastMatch ? roastMatch[1].toLowerCase().replace('é', 'e') : '';
        var name = card.querySelector('.js-product-name');
        var titleParts = name ? name.textContent.split(' | ') : [];
        var notes = normalizedTags.filter(function (tag) { return /^nota:/i.test(tag); }).map(function (tag) { return tag.slice(tag.indexOf(':') + 1).replace(/-/g, ' ').trim().toLowerCase(); }).filter(Boolean);
        if (!notes.length && titleParts.length > 1) {
            notes = titleParts[1].split(' — ')[0].split(/,|\s+e\s+/i).map(function (note) { return note.trim().toLowerCase(); }).filter(Boolean);
        }
        if (normalizedTags.some(function (tag) { return tag.toLowerCase().trim() === 'frutado'; }) && notes.indexOf('frutado') === -1) notes.push('frutado');
        var info = card.querySelector('.sulmina-home-product-card__info');
        var buyRow = info && info.querySelector('.sulmina-home-product-card__buy-row');
        if (!info || !buyRow) return;
        var meta = info.querySelector('.sulmina-home-product-card__producer');
        var producerLabel = card.getAttribute('data-sulmina-producer-label') || '';
        var producerLocation = card.getAttribute('data-sulmina-producer-location') || '';
        function updateMeta(originValue) {
            if (!originValue && !roast && !producerLabel) return;
            if (!meta) { meta = document.createElement('div'); meta.className = 'sulmina-home-product-card__producer'; name.insertAdjacentElement('afterend', meta); }
            var cleanOrigin = (originValue || '').trim();
            if (producerLabel && cleanOrigin.toLowerCase() === producerLabel.trim().toLowerCase()) cleanOrigin = '';
            if (producerLabel && cleanOrigin) {
                var escapedProducer = producerLabel.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
                cleanOrigin = cleanOrigin.replace(new RegExp('^\\s*' + escapedProducer + '\\s*[—–:-]\\s*', 'i'), '').trim();
            }
            var producerText = producerLabel ? 'de ' + producerLabel + (cleanOrigin ? ' · ' + cleanOrigin : (producerLocation ? ', ' + producerLocation : '')) : originValue;
            meta.textContent = [producerText, roast ? 'Torra ' + (roast === 'media' ? 'média' : roast) : ''].filter(Boolean).join(' · ');
            if (originValue && card.closest('.js-related-products')) {
                var productId = card.getAttribute('data-product-id');
                document.querySelectorAll('.js-related-products .sulmina-home-product-card').forEach(function (copy) {
                    if (copy === card || copy.getAttribute('data-product-id') !== productId) return;
                    var copyMeta = copy.querySelector('.sulmina-home-product-card__producer');
                    var copyName = copy.querySelector('.js-product-name');
                    if (!copyMeta && copyName) { copyMeta = document.createElement('div'); copyMeta.className = 'sulmina-home-product-card__producer'; copyName.insertAdjacentElement('afterend', copyMeta); }
                    if (copyMeta) copyMeta.textContent = meta.textContent;
                });
            }
        }
        if (!meta || origin || producerLabel) updateMeta(origin);
        /* The classic listing exposes an empty product.description. Read the
           matching public product page when the card approaches the viewport. */
        if (!origin && name && name.href && new URL(name.href, location.href).origin === location.origin) {
            var loadOrigin = function () {
                var url = new URL(name.href, location.href); url.search = ''; url.hash = '';
                var cache = window.__sulminaCardOrigins || (window.__sulminaCardOrigins = {});
                cache[url.href] = cache[url.href] || fetch(url.href, { credentials: 'same-origin' }).then(function (response) {
                    if (!response.ok) return '';
                    return response.text();
                }).then(function (html) {
                    if (!html) return '';
                    var page = new DOMParser().parseFromString(html, 'text/html');
                    var descriptionNode = page.querySelector('#single-product .user-content, .single-product .user-content');
                    if (!descriptionNode) return '';
                    var source = descriptionNode.innerHTML.replace(/<br\s*\/?>/gi, '\n').replace(/<\/p\s*>/gi, '\n').replace(/<\/div\s*>/gi, '\n');
                    var body = new DOMParser().parseFromString(source, 'text/html').body.textContent || '';
                    var match = body.match(/Origem:\s*([^\n]+)/i);
                    var found = match ? match[1].replace(/\s+/g, ' ').trim() : '';
                    return found.length <= 100 ? found : '';
                }).catch(function () { return ''; });
                cache[url.href].then(function (found) { if (found) updateMeta(found); });
            };
            if (card.closest('.js-related-products')) { loadOrigin(); }
            else if ('IntersectionObserver' in window) {
                var observer = new IntersectionObserver(function (entries) { if (entries.some(function (entry) { return entry.isIntersecting; })) { observer.disconnect(); loadOrigin(); } }, {rootMargin: '300px'});
                observer.observe(card);
            } else { loadOrigin(); }
        }
        var tagContainer = info.querySelector('.sulmina-home-product-card__tags');
        if (tagContainer && notes.length) {
            tagContainer.textContent = '';
            tagContainer.removeAttribute('aria-hidden');
            notes.forEach(function (note) { var label = document.createElement('span'); label.textContent = note; tagContainer.appendChild(label); });
        }
        if (roast) card.setAttribute('data-sulmina-roast', roast);
        if (notes.length) card.setAttribute('data-sulmina-notes', notes.join(' '));
        var variants = JSON.parse(card.getAttribute('data-variants') || '[]');
        if (Array.isArray(variants)) {
            var grinds = [];
            variants.forEach(function (variant) { ['option0','option1','option2'].forEach(function (key) { var value = String(variant[key] || '').toLowerCase(); if (/^gr[aã]os?$/.test(value) && grinds.indexOf('grao') === -1) grinds.push('grao'); if (/^mo[ií]do$/.test(value) && grinds.indexOf('moido') === -1) grinds.push('moido'); }); });
            if (grinds.length) card.setAttribute('data-sulmina-grind', grinds.join(' '));
        }
    } catch (error) {
        /* Preserve the original card if catalog data cannot be parsed. */
    }
})(document.currentScript);
</script>
