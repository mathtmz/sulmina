<main class="sulmina-product-page">
<div id="single-product" class="js-has-new-shipping js-product-detail js-product-container js-shipping-calculator-container pb-4 pt-md-4 pb-md-3" data-variants="{{product.variants_object | json_encode }}" data-store="product-detail">
    <div class="container mt-4 mt-md-0 mb-3 pt-md-1">
        <div class="row">
            <div class="col-md-7 pb-3 pr-md-2">
                {% include 'snipplets/product/product-image.tpl' %}
            </div>
            <div class="col" data-store="product-info-{{ product.id }}">
                {% include 'snipplets/product/product-form.tpl' %}
            </div>
        </div>
    </div>
</div>

{# Related products #}
{% include 'snipplets/product/product-related.tpl' %}
</main>
