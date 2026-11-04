{% set footer_navigation = menus[settings.footer_menu] %}

{% if has_footer_menu and footer_navigation %}
    <div class="sulmina-footer-links sulmina-footer-links--native" aria-label="Links da Sulmina">
        <nav class="sulmina-footer-link-group" aria-labelledby="sulmina-footer-navigation-title">
            <h3 id="sulmina-footer-navigation-title">Navegue</h3>
            <ul>
                {% for item in footer_navigation %}
                    {% set footer_item_name = item.name | default('') | trim | lower %}
                    {% if item.url and footer_item_name and 'newsletter' not in footer_item_name %}
                        <li><a href="{{ item.url | setting_url }}"{% if item.url | is_external %} target="_blank" rel="noopener"{% endif %}>{% if footer_item_name == 'produtos' %}Loja{% else %}{{ item.name }}{% endif %}</a></li>
                    {% endif %}
                    {% if item.subitems %}
                        {% for subitem in item.subitems %}
                            {% set footer_subitem_name = subitem.name | default('') | trim | lower %}
                            {% if subitem.url and footer_subitem_name and 'newsletter' not in footer_subitem_name %}
                                <li><a href="{{ subitem.url | setting_url }}"{% if subitem.url | is_external %} target="_blank" rel="noopener"{% endif %}>{{ subitem.name }}</a></li>
                            {% endif %}
                        {% endfor %}
                    {% endif %}
                {% endfor %}
            </ul>
        </nav>
    </div>
{% else %}
    <div class="sulmina-footer-links" aria-label="Links da Sulmina">
        <nav class="sulmina-footer-link-group" aria-labelledby="sulmina-footer-shop-title">
            <h3 id="sulmina-footer-shop-title">Loja</h3>
            <ul>
                <li><a href="{{ store.products_url }}">Todos os produtos</a></li>
                <li><a href="{{ footer_cart_url }}">Carrinho</a></li>
            </ul>
        </nav>
        <nav class="sulmina-footer-link-group" aria-labelledby="sulmina-footer-institutional-title">
            <h3 id="sulmina-footer-institutional-title">Institucional</h3>
            <ul>
                <li><a href="{{ store.url }}#sulmina-origem">Nossa História</a></li>
                <li><a href="/produtores/">Nossos Produtores</a></li>
                <li><a href="{{ footer_blog_url }}">Jornal</a></li>
            </ul>
        </nav>
        <nav class="sulmina-footer-link-group" aria-labelledby="sulmina-footer-help-title">
            <h3 id="sulmina-footer-help-title">Ajuda</h3>
            <ul>
                <li><a href="/perguntas-frequentes">Perguntas Frequentes</a></li>
                <li><a href="/contato/">Contato</a></li>
                <li><a href="{{ footer_account_url }}">Rastreio de pedido</a></li>
            </ul>
        </nav>
    </div>
{% endif %}
