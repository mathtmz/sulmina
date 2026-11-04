<main class="sulmina-help-page sulmina-account-page sulmina-account-page--addresses">
    <section class="sulmina-help-page__hero" aria-labelledby="sulmina-account-addresses-title">
        <div class="sulmina-help-page__hero-inner">
            <p class="sulmina-help-page__eyebrow">Área do cliente</p>
            <h1 id="sulmina-account-addresses-title">Meus endereços</h1>
            <span class="sulmina-help-page__hero-line" aria-hidden="true"></span>
        </div>
    </section>

<section class="sulmina-help-page__body sulmina-account-page__body sulmina-account-page__simple-body account-page">
    <div class="container">
        <div class="sulmina-account-page__simple-grid sulmina-account-page__simple-grid--addresses">
            <aside class="sulmina-account-page__simple-intro">
                <p class="sulmina-account-page__intro-eyebrow">Entrega sem complicação</p>
                <h2>Seus endereços, organizados.</h2>
                <p>Deixe tudo pronto para receber os produtos da Sulmina onde fizer mais sentido para você.</p>
            </aside>
            <div class="sulmina-account-page__address-panel">
        <div class="row">
            {% for address in customer.addresses %}

                {# User addresses listed - Main Address #}

                {% if loop.first %}
                    <div class="col-md-4 pr-md-4">
                        <h6 class="mb-3">{{ 'Principal' | translate }}</h6>

                {# User addresses listed - Other Addresses #}

                {% elseif loop.index == 2 %}
                    <div class="col-md-8">
                        <h6 class="mb-3 ml-md-1">{{ 'Otras direcciones' | translate }}</h6>
                        <div class="row pl-md-3">

                {% endif %}
                        {% if not loop.first %}
                            <div class="col-md-6 px-md-1">
                                <div class="card p-3">
                        {% endif %}
                                    <h6 class="mb-2">{{ address.name }} {{ 'Editar' | translate | a_tag(store.customer_address_url(address), '', 'btn-link font-small float-right') }}</h6>
                                    <p class="font-small mb-2">{{ address | format_address }}</p>
                        {% if not loop.first %}
                                </div>
                            </div>
                        {% endif %}
                {% if not loop.first and loop.last %}
                        </div>
                {% endif %}
                {% if loop.first %} 
                        <a class="btn-link mb-4 pb-2 d-inline-block" href="{{ store.customer_new_address_url }}"> {{ 'Agregar una nueva dirección' | translate }}</a>
                    </div>
                {% elseif loop.last %}
                    </div>
                {% endif %}
            {% endfor %}
        </div>
            </div>
        </div>
    </div>
</section>
</main>
