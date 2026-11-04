<div class="sulmina-loja-results">
    {% if products %}
        <div class="sulmina-loja-products-grid">
            {% for product in products %}
                {% include 'snipplets/home/home-product-card.tpl' %}
            {% endfor %}
        </div>
        <div class="sulmina-loja-no-results" hidden>Nenhum produto corresponde aos filtros selecionados.</div>
        <div class="sulmina-loja-banner">
            <p>{{ loja_banner_text }}</p>
            <a href="{{ loja_banner_url }}" class="sulmina-button sulmina-button--gold">{{ loja_banner_button }}</a>
        </div>
    {% else %}
        <div class="sulmina-empty-state">Nenhum produto encontrado.</div>
    {% endif %}
</div>
