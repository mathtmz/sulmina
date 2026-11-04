<section class="sulmina-trust" data-store="home-trust">
    <div class="sulmina-container sulmina-trust__grid">
        <div class="sulmina-trust__item">
            <img src="{{ 'images/sulmina-icon-brown.svg' | static_url }}" alt="" class="sulmina-differential-icon">
            <strong>{{ settings.home_trust_01_title | default('100% Sul de Minas') }}</strong><span>{{ settings.home_trust_01_text | default('terra de café premiado') }}</span>
        </div>
        <div class="sulmina-trust__item">
            <span class="sulmina-differential-icon sulmina-differential-icon--person" aria-hidden="true">
                <svg viewBox="0 0 48 48" role="presentation" focusable="false">
                    <circle cx="24" cy="13" r="7"></circle>
                    <path d="M10 39c0-8 6.3-14 14-14s14 6 14 14H10Z"></path>
                </svg>
            </span>
            <strong>{{ settings.home_trust_02_title | default('Produtor com nome e rosto') }}</strong><span>{{ settings.home_trust_02_text | default('você sabe quem plantou') }}</span>
        </div>
        <div class="sulmina-trust__item">
            <span class="sulmina-differential-icon sulmina-differential-icon--box" aria-hidden="true">
                <svg viewBox="0 0 48 48" role="presentation" focusable="false">
                    <path d="m24 6 15 8.5v19L24 42 9 33.5v-19L24 6Z"></path>
                    <path d="m9 14.5 15 9 15-9M24 23.5V42"></path>
                </svg>
            </span>
            <strong>{{ settings.home_trust_03_title | default('Embalado com carinho') }}</strong><span>{{ settings.home_trust_03_text | default('cada pedido preparado à mão, antes de seguir viagem') }}</span>
        </div>
    </div>
</section>
