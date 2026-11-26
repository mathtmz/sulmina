{% set social_network_list = social_network_list | default(['instagram', 'facebook', 'youtube', 'tiktok', 'twitter', 'pinterest']) %}
{% for sn in social_network_list %}
    {% set sn_url = attribute(store,sn) %}
    {% if sn_url %}
        <a class="social-icon" href="{{ sn_url }}" target="_blank" aria-label="{{ sn }} {{ store.name }}">
            {% if sn == "facebook" %}
                {% set social_network = sn ~ '-f' %}
            {% else %}
                {% set social_network = sn %}
            {% endif %}

            <svg class="icon-inline icon-lg"><use xlink:href="#{{ social_network }}"/></svg>
        </a>
    {% endif %}
{% endfor %}
