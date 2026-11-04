{% set newsletter_page_title = settings.newsletter_page_title | default('Assine nossa newsletter') %}
{% set newsletter_page_description = settings.newsletter_page_description | default('Receba novidades, histórias e lançamentos da Sulmina diretamente no seu e-mail.') %}
{% set newsletter_page_note = settings.newsletter_page_note | default('Sem spam. Apenas novidades da nossa terra.') %}
{% set newsletter_page_name_placeholder = settings.newsletter_page_name_placeholder | default('Seu nome completo') %}
{% set newsletter_page_email_placeholder = settings.newsletter_page_email_placeholder | default('Seu melhor e-mail') %}
{% set newsletter_page_button = settings.newsletter_page_button | default('Inscrever') %}
{% set newsletter_page_success = settings.newsletter_page_success | default('Pronto. Você está inscrito para receber as novidades da Sulmina.') %}
{% set newsletter_page_submitted = contact and contact.type == 'newsletter' %}

<main class="sulmina-newsletter-page" data-store="newsletter-page">
    <section class="sulmina-newsletter-page__hero">
        <div class="sulmina-container sulmina-newsletter-page__inner">
            <span class="sulmina-newsletter-page__eyebrow">Sulmina</span>
            <h1>{{ newsletter_page_title }}</h1>
            <p class="sulmina-newsletter-page__description">{{ newsletter_page_description }}</p>

            <div class="sulmina-newsletter-page__card">
                {% if not (newsletter_page_submitted and contact.success) %}
                    <form method="post" action="/winnie-pooh" onsubmit="this.setAttribute('action', '');" data-store="newsletter-page-form">
                        <div class="sulmina-newsletter-page__fields">
                            <div class="sulmina-newsletter-page__field">
                                <label for="sulmina-newsletter-page-name">{{ newsletter_page_name_placeholder }}</label>
                                <input id="sulmina-newsletter-page-name" class="form-control" type="text" name="name" placeholder="{{ newsletter_page_name_placeholder }}" autocomplete="name" required>
                            </div>
                            <div class="sulmina-newsletter-page__field">
                                <label for="sulmina-newsletter-page-email">{{ newsletter_page_email_placeholder }}</label>
                                <input id="sulmina-newsletter-page-email" class="form-control" type="email" name="email" placeholder="{{ newsletter_page_email_placeholder }}" autocomplete="email" required>
                            </div>
                            <button type="submit" name="contact" class="sulmina-newsletter-page__submit">{{ newsletter_page_button }}</button>
                        </div>
                        <div class="sulmina-newsletter-page__honeypot" aria-hidden="true">
                            <label for="winnie-pooh-newsletter-page">Não preencher este campo</label>
                            <input id="winnie-pooh-newsletter-page" type="text" name="winnie-pooh" tabindex="-1" autocomplete="off">
                        </div>
                        <input type="hidden" name="message" value="Inscrição na newsletter da Sulmina">
                        <input type="hidden" name="type" value="newsletter">
                    </form>
                {% endif %}

                {% if newsletter_page_submitted %}
                    {% if contact.success %}
                        <p class="sulmina-newsletter-page__feedback sulmina-newsletter-page__feedback--success" role="status">{{ newsletter_page_success }}</p>
                    {% else %}
                        <p class="sulmina-newsletter-page__feedback sulmina-newsletter-page__feedback--error" role="alert">Digite um nome e um e-mail válido para se inscrever.</p>
                    {% endif %}
                {% endif %}
            </div>

            <p class="sulmina-newsletter-page__note">{{ newsletter_page_note }}</p>
        </div>
    </section>
</main>
