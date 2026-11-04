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
    .sulmina-reference-footer .sulmina-footer-col ul { margin: 0 !important; padding: 0 !important; list-style: none !important; }
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
        .sulmina-reference-footer .sulmina-footer-grid { grid-template-columns: 1fr 1fr !important; gap: 32px !important; }
        .sulmina-reference-footer .sulmina-footer-col--brand { grid-column: auto !important; }
    }
    @media (max-width: 460px) {
        .sulmina-reference-footer .sulmina-footer-grid { grid-template-columns: 1fr !important; gap: 28px !important; }
    }
</style>

{% set footer_newsletter_title = settings.footer_newsletter_title %}
{% if not footer_newsletter_title %}{% set footer_newsletter_title = 'Assine nossa newsletter' %}{% endif %}
{% set footer_newsletter_name_placeholder = settings.footer_newsletter_name_placeholder | default('Seu nome') %}
{% set footer_newsletter_email_placeholder = settings.footer_newsletter_email_placeholder | default('Seu melhor e-mail') %}
{% set footer_newsletter_button = settings.footer_newsletter_button | default('Inscrever') %}
{% set footer_newsletter_success = settings.footer_newsletter_success | default('Pronto. Você está inscrito para receber as novidades da Sulmina.') %}
{% set footer_newsletter_submitted = contact and contact.type == 'newsletter' %}

<section class="sulmina-footer-newsletter" aria-labelledby="sulmina-footer-newsletter-title">
    <div class="sulmina-footer-newsletter__card">
        <h3 id="sulmina-footer-newsletter-title">{{ footer_newsletter_title }}</h3>
        <p>Receba novidades da Sulmina diretamente no seu e-mail.</p>

        {% if not (footer_newsletter_submitted and contact.success) %}
            <form method="post" action="/winnie-pooh" onsubmit="this.setAttribute('action', '');" data-store="newsletter-form">
                <div class="sulmina-footer-newsletter__fields">
                    <div class="sulmina-footer-newsletter__field">
                        <label class="sulmina-footer-newsletter__label--visually-hidden" for="sulmina-footer-newsletter-name">{{ footer_newsletter_name_placeholder }}</label>
                        <input id="sulmina-footer-newsletter-name" class="form-control" type="text" name="name" placeholder="{{ footer_newsletter_name_placeholder }}" autocomplete="name" required>
                    </div>
                    <div class="sulmina-footer-newsletter__field">
                        <label class="sulmina-footer-newsletter__label--visually-hidden" for="sulmina-footer-newsletter-email">{{ footer_newsletter_email_placeholder }}</label>
                        <input id="sulmina-footer-newsletter-email" class="form-control" type="email" name="email" placeholder="{{ footer_newsletter_email_placeholder }}" autocomplete="email" required>
                    </div>
                    <button type="submit" name="contact" class="sulmina-footer-newsletter__submit">{{ footer_newsletter_button }}</button>
                </div>
                <div class="winnie-pooh" style="display: none;">
                    <label for="winnie-pooh-footer-newsletter">Não preencher este campo</label>
                    <input id="winnie-pooh-footer-newsletter" type="text" name="winnie-pooh" tabindex="-1" autocomplete="off">
                </div>
                <input type="hidden" name="message" value="Inscrição na newsletter da Sulmina">
                <input type="hidden" name="type" value="newsletter">
            </form>
        {% endif %}

        {% if footer_newsletter_submitted %}
            {% if contact.success %}
                <p class="sulmina-footer-newsletter__feedback sulmina-footer-newsletter__feedback--success" role="status">{{ footer_newsletter_success }}</p>
            {% else %}
                <p class="sulmina-footer-newsletter__feedback sulmina-footer-newsletter__feedback--error" role="alert">Digite um nome e um e-mail válido para se inscrever.</p>
            {% endif %}
        {% endif %}
    </div>
</section>
