{% set footer_blog_url = store.blog_url ? store.blog_url : '/blog/' %}
{% set footer_cart_url = store.cart_url ? store.cart_url : '/carrinho/' %}
{% set footer_account_url = store.customer_login_url ? store.customer_login_url : '/conta/login/' %}
{% set footer_page_name = page.name | default('') | lower %}
{% set footer_page_url = page.url | default('') | lower %}
{% set is_newsletter_page = template == 'page' and ('newsletter' in footer_page_name or 'newsletter' in footer_page_url) %}
{% set is_producers_page = template == 'page' and ('produtor' in footer_page_name or 'produtor' in footer_page_url) %}
{% set is_story_page = template == 'page' and ('hist' in footer_page_name or 'hist' in footer_page_url) %}
{% set is_journal_page = template == 'blog' or template == 'blog-post' %}
{% set is_sulmina_footer_page = template == 'home' or template == 'category' or is_producers_page or is_story_page or is_journal_page %}

{{ component('nubesdk-slot', { type: "before_footer" }) }}

{% if template != 'password' and settings.news_show and is_sulmina_footer_page and not settings.prelaunch_enabled and not is_newsletter_page %}
    <div class="sulmina-footer-newsletter-wrap">
        <div class="container">
            {% include 'snipplets/footer-newsletter.tpl' %}
        </div>
    </div>
{% endif %}

<style>
    .sulmina-reference-footer { padding: 64px 0 24px !important; }
    .sulmina-reference-footer .sulmina-footer-grid {
        display: grid !important;
        grid-template-columns: 1.4fr repeat(3, minmax(0, 1fr)) !important;
        gap: 32px !important;
        margin-bottom: 48px !important;
        padding-bottom: 0 !important;
        border-bottom: 0 !important;
        text-align: left !important;
    }
    .sulmina-reference-footer .sulmina-footer-col { min-width: 0 !important; }
    .sulmina-reference-footer .sulmina-footer-col--brand { gap: 0 !important; }
    .sulmina-reference-footer .sulmina-footer-col--brand img { width: auto !important; height: 62px !important; }
    .sulmina-reference-footer .sulmina-footer-grid__social { gap: 14px !important; margin-top: 16px !important; }
    .sulmina-reference-footer .sulmina-footer-col h3 {
        margin: 0 0 16px !important;
        font-size: 13px !important;
        letter-spacing: .06em !important;
        text-transform: uppercase !important;
    }
    .sulmina-reference-footer .sulmina-footer-col ul {
        margin: 0 !important;
        padding: 0 !important;
        list-style: none !important;
    }
    .sulmina-reference-footer .sulmina-footer-col li { margin: 0 0 10px !important; }
    .sulmina-reference-footer .sulmina-footer-col li + li { margin-top: 0 !important; }
    .sulmina-reference-footer .sulmina-footer-col a { font-size: 14px !important; }
    .sulmina-reference-footer .sulmina-footer-powered-by { display: none !important; }
    .sulmina-reference-footer .sulmina-footer-legal {
        border-top: 1px solid rgba(255,255,255,.15) !important;
        padding-top: 24px !important;
        opacity: .7 !important;
        font-size: 13px !important;
    }
    @media (max-width: 760px) {
        .sulmina-reference-footer .sulmina-footer-grid {
            grid-template-columns: 1fr 1fr !important;
            gap: 32px !important;
        }
        .sulmina-reference-footer .sulmina-footer-col--brand { grid-column: auto !important; }
    }
    @media (max-width: 460px) {
        .sulmina-reference-footer .sulmina-footer-grid {
            grid-template-columns: 1fr !important;
            gap: 28px !important;
        }
    }
</style>

<footer class="js-footer sulmina-reference-footer overflow-none {% if settings.footer_colors %}footer-colors{% endif %}" data-store="footer">
    <div class="container">
        <div class="sulmina-footer-grid">
            <div class="sulmina-footer-col sulmina-footer-col--brand">
                <a href="{{ store.url }}" aria-label="{{ store.name }}">
                    <img src="{{ 'images/sulmina-logo-full-cream.svg' | static_url }}" alt="{{ store.name }} — Da nossa terra, pra sua mesa." width="170" height="50">
                </a>
                <div class="sulmina-footer-grid__social" aria-label="Redes sociais">
                    <a class="sulmina-footer-instagram" href="https://www.instagram.com/sulmina.co" target="_blank" rel="noopener" aria-label="Instagram da Sulmina">
                        <span class="sulmina-footer-instagram-mark" aria-hidden="true"></span>
                        <span>Instagram</span>
                    </a>
                    {% if store.whatsapp %}
                        <a class="sulmina-footer-social-link" href="{{ store.whatsapp }}" target="_blank" rel="noopener" aria-label="WhatsApp da Sulmina">
                            <svg class="icon-inline" aria-hidden="true"><use xlink:href="#whatsapp"></use></svg>
                            <span>WhatsApp</span>
                        </a>
                    {% endif %}
                </div>
            </div>

            <div class="sulmina-footer-col">
                <h3>Loja</h3>
                <ul>
                    <li><a href="{{ store.products_url }}">Todos os cafés</a></li>
                    <li><a href="{{ footer_cart_url }}">Carrinho</a></li>
                </ul>
            </div>

            <div class="sulmina-footer-col">
                <h3>Institucional</h3>
                <ul>
                    <li><a href="/nossa-historia">Nossa História</a></li>
                    <li><a href="/produtores/">Nossos Produtores</a></li>
                    <li><a href="{{ footer_blog_url }}">Jornal</a></li>
                </ul>
            </div>

            <div class="sulmina-footer-col">
                <h3>Ajuda</h3>
                <ul>
                    <li><a href="/perguntas-frequentes">Perguntas Frequentes</a></li>
                    <li><a href="/contato/">Contato</a></li>
                    <li><a href="{{ footer_account_url }}">Rastreio de pedido</a></li>
                </ul>
            </div>
        </div>

        {{ component('nubesdk-slot', { type: "inside_footer" }) }}

        <div class="sulmina-footer-powered-by my-2 text-center">
            {{ new_powered_by_link }}
        </div>

        <div class="sulmina-footer-bottom sulmina-footer-legal">
            <div class="d-inline-block mr-md-2 font-smallest">
                {{ "Copyright {1} - {2}. Todos los derechos reservados." | translate( (store.business_name ? store.business_name : store.name) ~ (store.business_id ? ' - ' ~ store.business_id : ''), "now" | date('Y') ) }}
            </div>
            <nav class="sulmina-footer-legal-links font-smallest" aria-label="Links legais">
                <a href="/politica-de-privacidade">Privacidade</a>
                <span aria-hidden="true">·</span>
                <a href="/termos-de-uso">Termos de Uso</a>
                <span aria-hidden="true">·</span>
                <a href="/trocas-e-devolucoes">Trocas e Devoluções</a>
            </nav>
        </div>
    </div>
</footer>

{{ component('nubesdk-slot', { type: "after_footer" }) }}
