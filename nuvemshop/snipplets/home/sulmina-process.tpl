{% set home_process_title = settings.home_process_title | default('Do Sul de Minas até a sua casa') %}
<section class="sulmina-process" data-store="home-process">
    <div class="sulmina-container">
        <div class="sulmina-section-heading sulmina-section-heading--center"><h2>{{ home_process_title }}</h2></div>
        <div class="sulmina-process__grid">
            <div class="sulmina-process__item"><span>1</span><h3>{{ settings.home_process_01_title | default('Escolha seu café') }}</h3><p>{{ settings.home_process_01_text | default('Grão inteiro ou moído, direto de um produtor com nome e história.') }}</p></div>
            <div class="sulmina-process__item"><span>2</span><h3>{{ settings.home_process_02_title | default('Embalamos com carinho') }}</h3><p>{{ settings.home_process_02_text | default('Cada pedido é preparado à mão, com cuidado, antes de seguir viagem até você.') }}</p></div>
            <div class="sulmina-process__item"><span>3</span><h3>{{ settings.home_process_03_title | default('Chega fresquinho na sua casa') }}</h3><p>{{ settings.home_process_03_text | default('Em qualquer lugar do Brasil, com a história do produtor no cartão.') }}</p></div>
        </div>
        <p class="sulmina-centered"><a class="sulmina-button sulmina-button--gold" href="{{ settings.home_hero_primary_url | default(store.products_url) }}">{{ settings.home_hero_primary_text | default('Comprar agora') }}</a></p>
    </div>
</section>
