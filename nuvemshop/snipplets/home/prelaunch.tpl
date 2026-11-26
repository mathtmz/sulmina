{% set prelaunch_title = settings.prelaunch_title | default('Do Sul de Minas, para a sua casa.') %}
{% set prelaunch_description_setting = settings.prelaunch_description | default('') %}
{% set prelaunch_description = prelaunch_description_setting | default('Produtos do Sul de Minas, com origem e cuidado.') %}
{% if prelaunch_description == 'Produtos com origem, história e cuidado. Estamos preparando o primeiro lançamento da Sulmina.' %}
    {% set prelaunch_description = 'Produtos do Sul de Minas, com origem e cuidado.' %}
{% endif %}
{% set prelaunch_collection_setting = settings.prelaunch_collection | default('') %}
{% set prelaunch_collection = prelaunch_collection_setting | default('Começaremos pelos cafés especiais. Em breve, novos produtos da nossa terra.') %}
{% if prelaunch_collection == 'Começamos pelos cafés especiais. Em breve, novos produtos da nossa terra.' %}
    {% set prelaunch_collection = 'Começaremos pelos cafés especiais. Em breve, novos produtos da nossa terra.' %}
{% endif %}
{% set prelaunch_signup_title = settings.prelaunch_signup_title | default('Quer saber primeiro do lançamento?') %}
{% set prelaunch_email_placeholder = settings.prelaunch_email_placeholder | default('Seu melhor e-mail') %}
{% set prelaunch_button = settings.prelaunch_button | default('Quero receber o lançamento') %}
{% set prelaunch_success = settings.prelaunch_success | default('Pronto. Você será avisado em primeira mão quando a Sulmina for lançada.') %}
{% set prelaunch_note_setting = settings.prelaunch_note | default('') %}
{% set prelaunch_note = prelaunch_note_setting | default('Inscreva-se e receba as novidades em primeira mão.') %}
{% if prelaunch_note == 'Só novidades da Sulmina.' or prelaunch_note == 'Sem spam. Apenas novidades da Sulmina.' %}
    {% set prelaunch_note = 'Inscreva-se e receba as novidades em primeira mão.' %}
{% endif %}
{% set prelaunch_image = 'home_hero_image.jpg' | has_custom_image %}
{% set prelaunch_logo = 'images/sulmina-logo-brown.svg' %}
{% if prelaunch_image %}{% set prelaunch_logo = 'images/sulmina-logo-cream.svg' %}{% endif %}

<main class="sulmina-prelaunch-page{% if prelaunch_image %} sulmina-prelaunch-page--image{% endif %}" data-store="prelaunch-page" data-newsletter-success="{% if contact and contact.type == 'newsletter' and contact.success %}true{% else %}false{% endif %}"{% if prelaunch_image %} style="--sulmina-prelaunch-image: url('{{ 'home_hero_image.jpg' | static_url | settings_image_url('1080p') }}');"{% endif %}>
    <div class="sulmina-prelaunch__frame">
        <section class="sulmina-prelaunch__copy" aria-labelledby="sulmina-prelaunch-title">
            <a class="sulmina-prelaunch__brand" href="{{ store.url }}" aria-label="{{ store.name }}">
                <img src="{{ prelaunch_logo | static_url }}" alt="{{ store.name }}" width="144" height="42">
            </a>

            <div class="sulmina-prelaunch__content">
                <h1 id="sulmina-prelaunch-title">{{ prelaunch_title }}</h1>
                <p class="sulmina-prelaunch__description">{{ prelaunch_description }}</p>
                <p class="sulmina-prelaunch__collection">{{ prelaunch_collection }}</p>

                <section class="sulmina-prelaunch__launch" aria-labelledby="sulmina-prelaunch-launch-title" data-countdown-target="2026-11-26T19:00:00-03:00">
                    <h2 id="sulmina-prelaunch-launch-title">O lançamento está chegando!</h2>
                    <p class="sulmina-prelaunch__launch-date">A loja SULMINA abre em <strong>26 de novembro de 2026, às 19h</strong>.</p>
                    <div class="sulmina-prelaunch__countdown" data-launch-countdown role="timer" aria-label="Contagem regressiva para o lançamento">
                        <span><strong data-countdown-days>00</strong><small>dias</small></span>
                        <span><strong data-countdown-hours>00</strong><small>horas</small></span>
                        <span><strong data-countdown-minutes>00</strong><small>minutos</small></span>
                        <span><strong data-countdown-seconds>00</strong><small>segundos</small></span>
                    </div>
                    <p class="sulmina-prelaunch__countdown-ended" data-countdown-ended hidden>A loja já abriu. Vem conhecer nossos cafés!</p>
                </section>

                <div class="sulmina-prelaunch__signup">
                    <h2 class="sulmina-prelaunch__signup-title"{% if contact and contact.type == 'newsletter' and contact.success %} hidden{% endif %}>{{ prelaunch_signup_title }}</h2>
                    <form method="post" action="/winnie-pooh" onsubmit="this.setAttribute('action', '');" data-store="newsletter-form"{% if contact and contact.type == 'newsletter' and contact.success %} hidden{% endif %}>
                        <div class="sulmina-prelaunch__form-row">
                            <div class="sulmina-prelaunch__field">
                                <label class="sulmina-prelaunch__label sulmina-prelaunch__label--visually-hidden" for="sulmina-prelaunch-name">Seu Nome</label>
                                <input id="sulmina-prelaunch-name" type="text" name="name" placeholder="Seu Nome" autocomplete="name" aria-label="Seu Nome" required>
                            </div>
                            <div class="sulmina-prelaunch__field">
                                <label class="sulmina-prelaunch__label sulmina-prelaunch__label--visually-hidden" for="sulmina-prelaunch-email">{{ prelaunch_email_placeholder }}</label>
                                <input id="sulmina-prelaunch-email" type="email" name="email" placeholder="{{ prelaunch_email_placeholder }}" autocomplete="email" aria-label="{{ prelaunch_email_placeholder }}" required aria-describedby="sulmina-prelaunch-note">
                            </div>
                            <div class="winnie-pooh" style="display: none;">
                                <label for="winnie-pooh-prelaunch">Não preencher este campo</label>
                                <input id="winnie-pooh-prelaunch" type="text" name="winnie-pooh" tabindex="-1" autocomplete="off">
                            </div>
                            <input type="hidden" name="message" value="Inscrição para receber o lançamento da Sulmina">
                            <input type="hidden" name="type" value="newsletter">
                            <input type="submit" name="contact" class="sulmina-prelaunch__submit" value="{{ prelaunch_button }}">
                        </div>
                    </form>

                    {% if contact and contact.type == 'newsletter' %}
                        {% if contact.success %}
                            <p class="sulmina-prelaunch__feedback sulmina-prelaunch__feedback--success" role="status">{{ prelaunch_success }}</p>
                        {% else %}
                            <p class="sulmina-prelaunch__feedback sulmina-prelaunch__feedback--error" role="alert">Digite um e-mail válido para receber o aviso de lançamento.</p>
                        {% endif %}
                    {% endif %}

                    <p class="sulmina-prelaunch__feedback sulmina-prelaunch__feedback--success" data-prelaunch-persistent-success role="status" hidden>{{ prelaunch_success }}</p>

                    <p id="sulmina-prelaunch-note" class="sulmina-prelaunch__note"{% if contact and contact.type == 'newsletter' and contact.success %} hidden{% endif %}>{{ prelaunch_note }}</p>
                </div>
            </div>

            {% if template == 'password' %}
                <footer class="sulmina-prelaunch__footer">
                    <details class="sulmina-prelaunch__password-access"{% if invalid_password %} open{% endif %}>
                        <summary>Acesso da equipe</summary>
                        {% embed "snipplets/forms/form.tpl" with{form_id: 'password-form', submit_text: 'Desbloquear' | translate, submit_custom_class: 'sulmina-prelaunch__password-submit', form_custom_class: 'sulmina-prelaunch__password-form' } %}
                            {% block form_body %}
                                {% embed "snipplets/forms/form-input.tpl" with{input_for: 'password', type_password: true, input_name: 'password', input_label_text: 'Senha de acesso' | translate, input_placeholder: 'Digite a senha' | translate } %}
                                {% endembed %}
                            {% endblock %}
                            {% block form_alerts %}
                                {% if invalid_password == true %}
                                    <div class="sulmina-prelaunch__password-error">A senha está incorreta.</div>
                                {% endif %}
                            {% endblock %}
                        {% endembed %}
                    </details>
                </footer>
            {% endif %}
        </section>

    </div>
</main>

<style>
.sulmina-prelaunch-page .sulmina-prelaunch__launch { box-sizing: border-box; width: min(100%, 560px); margin: 24px auto 0; padding: 22px clamp(16px, 3vw, 28px) 24px; border: 1px solid rgba(244,238,225,.55); border-radius: 10px; background: rgba(92,110,74,.78); background: color-mix(in srgb, var(--sul-verde) 78%, transparent); box-shadow: 0 10px 30px rgba(0,0,0,.2); backdrop-filter: blur(2px); color: var(--sul-creme); }
.sulmina-prelaunch-page .sulmina-prelaunch__launch h2 { margin: 0 0 10px; color: var(--sul-creme); font-family: var(--sul-serif); font-size: clamp(25px, 3vw, 32px); line-height: 1.1; }
.sulmina-prelaunch-page .sulmina-prelaunch__launch-date,
.sulmina-prelaunch-page .sulmina-prelaunch__launch-date strong { margin: 0; color: var(--sul-creme); font-size: 16px; line-height: 1.45; }
.sulmina-prelaunch-page .sulmina-prelaunch__countdown { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 8px; margin: 20px auto 0; }
.sulmina-prelaunch-page .sulmina-prelaunch__countdown span { display: flex; min-width: 0; flex-direction: column; align-items: center; gap: 5px; padding: 10px 6px; border: 1px solid rgba(244,238,225,.28); border-radius: 7px; background: rgba(244,238,225,.12); text-align: center; }
.sulmina-prelaunch-page .sulmina-prelaunch__countdown strong { color: var(--sul-creme); font-size: clamp(22px, 3vw, 28px); font-variant-numeric: tabular-nums; line-height: 1; }
.sulmina-prelaunch-page .sulmina-prelaunch__countdown small { margin: 0; color: var(--sul-creme); font-size: 11px; line-height: 1.2; }
.sulmina-prelaunch-page .sulmina-prelaunch__countdown-ended { margin: 12px 0 0; color: var(--sul-creme); font-family: var(--sul-serif); font-size: 18px; }
@media (max-width: 760px) {
    .sulmina-prelaunch-page .sulmina-prelaunch__launch { margin-top: 16px; }
    .sulmina-prelaunch-page .sulmina-prelaunch__countdown { gap: 6px; }
    .sulmina-prelaunch-page .sulmina-prelaunch__countdown span { padding: 9px 4px; }
    .sulmina-prelaunch-page .sulmina-prelaunch__countdown strong { font-size: 21px; }
    .sulmina-prelaunch-page .sulmina-prelaunch__countdown small { font-size: 10px; }
}
</style>

<script>
(function () {
    var launch = document.querySelector('[data-countdown-target]');
    if (!launch) return;

    var target = new Date(launch.getAttribute('data-countdown-target')).getTime();
    var countdown = launch.querySelector('[data-launch-countdown]');
    var ended = launch.querySelector('[data-countdown-ended]');
    var fields = {
        days: launch.querySelector('[data-countdown-days]'),
        hours: launch.querySelector('[data-countdown-hours]'),
        minutes: launch.querySelector('[data-countdown-minutes]'),
        seconds: launch.querySelector('[data-countdown-seconds]')
    };

    function updateCountdown() {
        var remaining = Math.max(0, target - Date.now());
        var seconds = Math.floor(remaining / 1000);
        fields.days.textContent = String(Math.floor(seconds / 86400));
        fields.hours.textContent = String(Math.floor((seconds % 86400) / 3600)).padStart(2, '0');
        fields.minutes.textContent = String(Math.floor((seconds % 3600) / 60)).padStart(2, '0');
        fields.seconds.textContent = String(seconds % 60).padStart(2, '0');

        if (remaining === 0) {
            countdown.hidden = true;
            ended.hidden = false;
            clearInterval(interval);
        }
    }

    updateCountdown();
    var interval = window.setInterval(updateCountdown, 1000);
}());
</script>
