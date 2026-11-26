<section class="sulmina-loja-filter-tools" aria-label="Filtros da loja">
    <div class="sulmina-loja-filter-toolbar">
        <button
            class="sulmina-loja-filter-trigger"
            type="button"
            data-loja-filter-open
            aria-haspopup="dialog"
            aria-expanded="false"
            aria-controls="sulmina-loja-filter-dialog"
            aria-label="Filtros">
            <svg aria-hidden="true" viewBox="0 0 24 24" focusable="false">
                <path d="M4 6h16M7 12h10m-7 6h4" fill="none" stroke="currentColor" stroke-linecap="round" stroke-width="1.8"/>
            </svg>
            <span>Filtros</span>
            <span class="sulmina-loja-filter-badge" data-loja-filter-badge hidden></span>
        </button>
        <p class="sulmina-loja-results-count" data-loja-results-count aria-live="polite">
            {% if products %}{{ products | length }} produtos{% else %}Nenhum produto{% endif %}
        </p>
    </div>

    <div class="sulmina-loja-filter-overlay" data-loja-filter-overlay aria-hidden="true" hidden>
        <button class="sulmina-loja-filter-backdrop" type="button" data-loja-filter-dismiss aria-label="Fechar filtros"></button>
        <aside
            class="sulmina-loja-filter-panel"
            id="sulmina-loja-filter-dialog"
            role="dialog"
            aria-modal="true"
            aria-labelledby="sulmina-loja-filter-title"
            tabindex="-1">
            <header class="sulmina-loja-filter-header">
                <div>
                    <h2 id="sulmina-loja-filter-title">Filtros</h2>
                    <p>Escolha o que procura e aplique.</p>
                </div>
                <button class="sulmina-loja-filter-close" type="button" data-loja-filter-dismiss aria-label="Fechar filtros">&times;</button>
            </header>

            <div class="sulmina-loja-filter-content">
                <div class="sulmina-loja-filter-group" data-loja-filter-section="roast">
                    <h3>Torra</h3>
                    <label class="sulmina-loja-filter-option"><input type="checkbox" data-loja-filter-group="roast" value="clara"><span>Clara</span><span class="sulmina-loja-option-count" data-loja-option-count></span></label>
                    <label class="sulmina-loja-filter-option"><input type="checkbox" data-loja-filter-group="roast" value="media"><span>Média</span><span class="sulmina-loja-option-count" data-loja-option-count></span></label>
                    <label class="sulmina-loja-filter-option"><input type="checkbox" data-loja-filter-group="roast" value="escura"><span>Escura</span><span class="sulmina-loja-option-count" data-loja-option-count></span></label>
                </div>

                <div class="sulmina-loja-filter-group" data-loja-filter-section="notes">
                    <h3>Notas sensoriais</h3>
                    <label class="sulmina-loja-filter-option"><input type="checkbox" data-loja-filter-group="notes" value="chocolate"><span>Chocolate</span><span class="sulmina-loja-option-count" data-loja-option-count></span></label>
                    <label class="sulmina-loja-filter-option"><input type="checkbox" data-loja-filter-group="notes" value="caramelo"><span>Caramelo</span><span class="sulmina-loja-option-count" data-loja-option-count></span></label>
                    <label class="sulmina-loja-filter-option"><input type="checkbox" data-loja-filter-group="notes" value="laranja"><span>Laranja</span><span class="sulmina-loja-option-count" data-loja-option-count></span></label>
                    <label class="sulmina-loja-filter-option"><input type="checkbox" data-loja-filter-group="notes" value="floral"><span>Floral</span><span class="sulmina-loja-option-count" data-loja-option-count></span></label>
                    <label class="sulmina-loja-filter-option"><input type="checkbox" data-loja-filter-group="notes" value="nozes"><span>Nozes</span><span class="sulmina-loja-option-count" data-loja-option-count></span></label>
                    <label class="sulmina-loja-filter-option"><input type="checkbox" data-loja-filter-group="notes" value="mel"><span>Mel</span><span class="sulmina-loja-option-count" data-loja-option-count></span></label>
                    <label class="sulmina-loja-filter-option"><input type="checkbox" data-loja-filter-group="notes" value="frutado"><span>Frutado</span><span class="sulmina-loja-option-count" data-loja-option-count></span></label>
                </div>

                {% set sulmina_producer_filters = [
                    {'slug': settings.home_producer_01_slug | default('doceira-coffees'), 'name': settings.home_producer_01_name},
                    {'slug': settings.home_producer_02_slug | default('grao-bao'), 'name': settings.home_producer_02_name},
                    {'slug': settings.home_producer_03_slug | default('coopfam'), 'name': settings.home_producer_03_name},
                    {'slug': settings.home_producer_04_slug, 'name': settings.home_producer_04_name},
                    {'slug': settings.home_producer_05_slug, 'name': settings.home_producer_05_name},
                    {'slug': settings.home_producer_06_slug, 'name': settings.home_producer_06_name},
                    {'slug': settings.home_producer_07_slug, 'name': settings.home_producer_07_name},
                    {'slug': settings.home_producer_08_slug, 'name': settings.home_producer_08_name}
                ] %}
                {% set has_sulmina_producer_filter = false %}
                {% for producer in sulmina_producer_filters %}{% if producer.slug and producer.name %}{% set has_sulmina_producer_filter = true %}{% endif %}{% endfor %}
                {% if has_sulmina_producer_filter %}
                    <div class="sulmina-loja-filter-group" data-loja-filter-section="producer">
                        <h3>Produtor</h3>
                        {% for producer in sulmina_producer_filters %}
                            {% if producer.slug and producer.name %}
                                <label class="sulmina-loja-filter-option"><input type="checkbox" data-loja-filter-group="producer" value="{{ producer.slug }}"><span>{{ producer.name }}</span><span class="sulmina-loja-option-count" data-loja-option-count></span></label>
                            {% endif %}
                        {% endfor %}
                    </div>
                {% endif %}

                <div class="sulmina-loja-filter-group" data-loja-filter-section="grind">
                    <h3>Moagem</h3>
                    <label class="sulmina-loja-filter-option"><input type="radio" name="sulmina-moagem" data-loja-filter-group="grind" value="grao"><span>Grão</span><span class="sulmina-loja-option-count" data-loja-option-count></span></label>
                    <label class="sulmina-loja-filter-option"><input type="radio" name="sulmina-moagem" data-loja-filter-group="grind" value="moido"><span>Moído</span><span class="sulmina-loja-option-count" data-loja-option-count></span></label>
                </div>
            </div>

            <footer class="sulmina-loja-filter-footer">
                <button class="sulmina-loja-filter-clear" type="button" data-loja-filter-clear>Limpar</button>
                <button class="sulmina-loja-filter-apply" type="button" data-loja-filter-apply>Aplicar filtros</button>
            </footer>
        </aside>
    </div>
</section>
