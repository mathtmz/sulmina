{# Check if store has free shipping without regions or categories #}

{% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}
{% set has_free_shipping_bar = has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

{% set price_without_taxes_container_classes = "row opacity-50" %}
{% set price_without_taxes_label_classes = "col-auto" %}
{% set price_without_taxes_price_classes = "col text-right" %}

{% set gift_progress_parameters = {
  check_svg_id: 'check',
  show_check: true,
  progress_bar_classes: {
    container: 'progress-bar',
    title_container: 'progress-bar-title-container',
    title: 'progress-bar-title text-accent',
    subtitle: 'progress-bar-subtitle opacity-50',
    track: 'bar-progress',
    fill: 'bar-progress-active transition-soft',
    check: 'bar-progress-check transition-soft',
    check_icon: 'icon-inline',
  }
} %}

{% if cart_page %}
  <div class="d-block d-md-none">
{% endif %}
    {{ component('gift-promotion-progress', gift_progress_parameters) }}
{% if cart_page %}
  </div>
{% endif %}

{% if has_free_shipping_bar %}

  {# includes free shipping progress bar: only if store has free shipping with a minimum #}

  {% if cart_page %}
    <div class="d-block d-md-none">
  {% endif %}
      {% include "snipplets/shipping/shipping-free-rest.tpl" %}
  {% if cart_page %}
    </div>
  {% endif %}

{% endif %}

{# Define conditions to show shipping calculator and store branches on cart #}

{% set show_calculator_on_cart = settings.shipping_calculator_cart_page and store.has_shipping %}
{% set show_cart_fulfillment = settings.shipping_calculator_cart_page and (store.has_shipping or store.branches) %}

{% if cart_page %}

  {# Cart page subtotal #}

  <div id="cart-sticky-summary" class="position-sticky-md cart-page-totals">
    <div class="d-none d-md-block">
      {{ component('gift-promotion-progress', gift_progress_parameters) }}
    </div>

    {% if has_free_shipping_bar %}
      {# includes free shipping progress bar: only if store has free shipping with a minimum #}

      <div class="d-none d-md-block">
        {% include "snipplets/shipping/shipping-free-rest.tpl" %}
      </div>
    {% endif %}
{% else %}

  {# Cart fulfillment #}

  {% if not cart.free_shipping.cart_has_free_shipping %}
    {% include "snipplets/shipping/cart-fulfillment.tpl" %}
  {% endif %}
{% endif %}
  
    {% if settings.cart_coupon %}
      <div class="js-visible-on-cart-filled mb-2" {% if cart.items_count == 0 %}style="display:none;"{% endif %}>
        {{ component('coupon-input', {
          label_svg_id: 'tag',
          toggle_inactive_svg_id: 'plus',
          toggle_active_svg_id: 'minus',
          spinner_svg_id: 'spinner-third',
          container_classes: {
            container: 'pb-3 mb-3 bottom-line',
            content: '',
            toggle: 'd-flex align-items-center justify-content-between w-100',
            toggle_icon: 'icon-inline',
            toggle_label: 'd-flex align-items-center font-medium',
            label_icon: 'icon-inline mr-2',
            actions: 'mt-2',
            applied_row: 'd-flex align-items-center justify-content-between',
            applied_code: 'mr-4 font-medium',
            remove_button: 'btn-link font-small coupon-action-btn',
            form: 'mb-0',
            input_wrapper: 'form-group position-relative mb-1',
            input: 'form-control form-control-big',
            apply_button: 'form-control-submit btn-link font-small coupon-action-btn',
            spinner_icon: 'icon-inline icon-spin',
            spinner: 'ml-2',
            error: 'alert alert-danger mb-0 mt-2',
          }
        }) }}
      </div>
    {% endif %}

    {# Cart totals #}
    <div class="sulmina-cart-summary-wrap">
      <div
        class="sulmina-cart-summary"
        data-sulmina-cart-summary
        data-cart-subtotal="{{ cart.subtotal }}"
        data-cart-shipping="{{ cart.shipping_cost | default(0) }}"
        data-cart-total="{{ cart.total }}"
        data-cart-promotion-discount="{{ cart.promotional_discount_amount | default(0) }}"
        data-cart-currency="{{ cart.currency | default(store.currency) }}"
        data-cart-free-shipping="{{ cart.free_shipping.cart_has_free_shipping ? 'true' : 'false' }}"
        data-cart-calculator-enabled="{{ show_calculator_on_cart ? 'true' : 'false' }}"
        aria-label="Resumo do pedido"
      >
        <div class="sulmina-cart-summary__row"><span>Subtotal (sem frete)</span><span data-sulmina-summary-subtotal>{{ cart.subtotal | money }}</span></div>
        <div class="sulmina-cart-summary__row sulmina-cart-summary__row--discount"><span>Desconto</span><span data-sulmina-summary-discount>{% if cart.promotional_discount_amount > 0 %}-{{ cart.promotional_discount_amount | money }}{% else %}{{ 0 | money }}{% endif %}</span></div>
        <div class="sulmina-cart-summary__row"><span>Frete</span><span data-sulmina-summary-shipping>{% if cart.free_shipping.cart_has_free_shipping %}Grátis{% elseif cart.shipping_cost > 0 %}{{ cart.shipping_cost | money }}{% elseif show_calculator_on_cart %}Calcule para ver{% else %}Calculado no checkout{% endif %}</span></div>
        <div class="sulmina-cart-summary__row sulmina-cart-summary__row--total"><span>Total</span><span data-sulmina-summary-total>{{ cart.total | money }}</span></div>
      </div>

      {# Keep the native totals component in the DOM for cart, shipping, coupon and payment scripts. #}
      {{ component('cart-totals', {
        shipping_enabled: show_calculator_on_cart,
        shipping_discount_row_enabled: true,
        payment_discount_price_enabled: settings.payment_discount_price,
        installments_enabled: not settings.payment_discount_price,
        totals_divider: false,
        text_classes: {
          subtotals_row: 'd-grid grid-1-auto mb-2',
          subtotal: cart_page ? 'sulmina-native-subtotal-row h5 row no-gutters font-big mb-1' : 'sulmina-native-subtotal-row h5 font-big row mb-1',
          subtotal_label: cart_page ? 'col-auto pl-md-0' : 'col-7',
          subtotal_price: cart_page ? 'col text-right pr-md-0' : 'col text-right',
          price_without_taxes: price_without_taxes_container_classes,
          price_without_taxes_label: price_without_taxes_label_classes,
          price_without_taxes_price: price_without_taxes_price_classes,
          promotions: 'sulmina-native-promotions d-none',
          discounts_row: cart_page ? 'sulmina-native-discounts-row row no-gutters mb-2' : 'sulmina-native-discounts-row row no-gutters d-grid grid-1-auto mb-2',
          shipping_costs: 'sulmina-native-shipping-row js-fulfillment-info js-shipping-cost-table h6 font-body mb-2 row no-gutters',
          shipping_costs_label: 'col-auto pl-md-0',
          shipping_costs_price: 'sulmina-native-shipping-price col text-right opacity-40 pr-md-0',
          shipping_costs_calculating: 'col text-right opacity-40 pr-md-0',
          shipping_costs_empty: 'col text-right opacity-40 pr-md-0',
          total: cart_page ? 'sulmina-native-total-row h2 row no-gutters font-huge mb-2' : 'sulmina-native-total-row h2 row font-huge mb-2',
          total_label: cart_page ? 'col-auto pl-md-0' : 'col-auto',
          total_price: cart_page ? 'sulmina-native-total-price col text-right pr-md-0' : 'sulmina-native-total-price col text-right',
          payment_discount_and_installments: cart_page ? 'sulmina-native-payment-details d-none col-12 pr-md-0' : 'sulmina-native-payment-details d-none col-12',
          payment_discount_price: 'font-small text-right',
          installments: 'font-small text-right',
          discounts_label: 'col pr-3 text-accent',
          discounts_price: cart_page ? 'col-auto text-right pr-md-0 text-accent' : 'col-auto text-right text-accent',
          shipping_discount_row: cart_page ? 'sulmina-native-shipping-discount-row d-none row no-gutters mb-2' : 'sulmina-native-shipping-discount-row d-none row mb-2',
          shipping_discount_label: cart_page ? 'col-auto pl-md-0 text-uppercase' : 'col-auto text-uppercase',
          shipping_discount_price: cart_page ? 'col text-right pr-md-0' : 'col text-right',
        },
      }) }}
    </div>

    {{ component('nubesdk-slot', { type: "before_go_to_checkout" }) }}

    <div class="js-visible-on-cart-filled" {% if cart.items_count == 0 %}style="display:none;"{% endif %}>

      {# Cart page and popup CTA Module #}

      {% set has_validation_messages = cart.checkout_enabled_validation_messages | length > 0 %}
      {% set should_show_checkout_button = cart.checkout_enabled and has_validation_messages == false %}

      {% if cart_page %}

        {# Cart page CTA and minimum alert: Always render button to ensure it exists in DOM, control visibility via CSS/JS #}

        <input id="go-to-checkout" class="btn btn-primary btn-big btn-block mb-2" {{ not should_show_checkout_button ? 'style="display:none"' }} type="submit" name="go_to_checkout" value="{{ 'Iniciar Compra' | translate }}"/>

        {# Cart alert messages #}
        {{ component(
          'checkout-enabled-validation-messages', {
            alert_classes: 'alert alert-warning w-100 mb-2 text-center',
            cart_minimum_value: settings.cart_minimum_value
          })
        }}

      {% else %}

        {# Cart popup CTA and minimum alert #}

        <div class="js-ajax-cart-submit mb-2" {{ not should_show_checkout_button ? 'style="display:none"' }} id="ajax-cart-submit-div" >
          <input class="btn btn-primary btn-big btn-block" type="submit" name="go_to_checkout" value="{{ 'Iniciar Compra' | translate }}" data-component="cart.checkout-button"/>
        </div>

        {# Cart alert messages #}
        {{ component(
          'checkout-enabled-validation-messages', {
            alert_classes: 'alert alert-warning mb-2 text-center',
            cart_minimum_value: settings.cart_minimum_value
          })
        }}

      {% endif %}

      {# Cart panel continue buying link #}

      {% if settings.continue_buying %}
        <div class="text-center w-100 {% if not cart_page %}mb-md-2{% endif %} pb-3">
          <a href="{% if cart_page %}{{ store.products_url }}{% else %}#{% endif %}" class="{% if not cart_page %}js-modal-close js-fullscreen-modal-close{% endif %} btn-link">{{ 'Ver más productos' | translate }}</a>
        </div>
      {% endif %}
    </div>

    {{ component('nubesdk-slot', { type: "after_go_to_checkout" }) }}
    
{% if cart_page %}
  {# End of sticky module #}
  </div>
{% endif %}
