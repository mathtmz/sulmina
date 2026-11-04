<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/">
    <head>
        <link rel="preconnect" href="{{ store_resource_hints }}" />
        <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>{{ page_title }}</title>
        <meta name="description" content="{{ page_description }}" />

        {% set italic_font = params.preview %}
        {% set google_fonts_weights = italic_font ? '400,400italic,700' : '400,700' %}

        <link rel="preload" as="style" href="{{ [settings.font_headings, settings.font_rest] | google_fonts_url(google_fonts_weights) }}" />
        <link rel="preload" href="{{ 'css/style-critical.scss' | static_url }}" as="style" />
        <link rel="preload" href="{{ 'css/style-colors.scss' | static_url }}" as="style" />
        
        {{ component('social-meta') }}

        {#/*============================================================================
            #CSS and fonts
        ==============================================================================*/#}

        {# Critical CSS needed to show first elements of store while CSS async is loading #}

        <style>
            {# Font families #}

            {{ component(
                'fonts',{
                    font_weights: google_fonts_weights,
                    font_settings: 'settings.font_headings, settings.font_rest'
                })
            }}

            {# General CSS Tokens #}

            {% include "static/css/style-tokens.tpl" %}

        </style>

        {# Critical CSS #}

        {{ 'css/style-critical.scss' | static_url | static_inline }}

        {# Colors and fonts used from settings.txt and defined on theme customization #}

        {{ 'css/style-colors.scss' | static_url | static_inline }}

        {# Load async styling not mandatory for first meaningfull paint #}

        <link rel="stylesheet" href="{{ 'css/style-async.scss' | static_url }}" media="print" onload="this.media='all'">

        <link rel="stylesheet" href="{{ 'css/sulmina.css' | static_url }}?v=20260921-20">

        {# Loads custom CSS added from Advanced Settings on the admin´s theme customization screen #}

        <style>
            {{ settings.css_code | raw }}
        </style>

        {# Critical construction-page overrides: keep the password view independent from Morelia's legacy styles and CDN cache. #}
        <style>
            .body-password.sulmina-prelaunch-mode { background: #F4EEE1 !important; color: #2E2620 !important; overflow-x: hidden; overflow-y: auto !important; }
            .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__copy { height: auto !important; min-height: 100svh !important; overflow: visible !important; padding-top: 50px !important; }
            .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__footer { min-height: 0 !important; margin-top: 14px !important; padding: 0 !important; border: 0 !important; background: transparent !important; box-shadow: none !important; color: #2E2620 !important; }
            .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__brand img { width: 156px !important; height: auto !important; }
            .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__content h1 { font-size: clamp(32px, 4vw, 54px) !important; }
            .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__password-access,
            .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__password-access > *,
            .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__password-access .form,
            .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__password-access .form-group { background: transparent !important; box-shadow: none !important; }
            .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__password-access { display: block; width: min(100%, 320px); margin: 0 auto; color: rgba(46,38,32,.64); font-size: 12px; text-align: center; }
            .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__password-access summary { display: inline-flex; align-items: center; justify-content: center; gap: 8px; min-height: 34px; padding: 7px 13px; border: 1px solid rgba(140,90,52,.28); border-radius: 999px; background: rgba(251,248,242,.72) !important; color: #8C5A34 !important; cursor: pointer; font-size: 10px; font-weight: 700; letter-spacing: .1em; line-height: 1; list-style: none; text-transform: uppercase; }
            .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__password-access summary::before { width: 6px; height: 6px; border-radius: 50%; background: #D69A3E; content: ''; }
            .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__password-access summary::-webkit-details-marker { display: none; }
            .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__password-access[open] summary { border-color: #8C5A34; background: #8C5A34 !important; color: #FBF8F2 !important; }
            .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__password-access[open] summary::before { background: #FBF8F2; }
            @media (max-width: 760px) {
                .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__brand img { width: 144px !important; }
                .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__content h1 { font-size: clamp(29px, 8.8vw, 43px) !important; }
            }
            @media (max-height: 850px) {
                .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__brand img { width: 138px !important; }
                .body-password.sulmina-prelaunch-mode .sulmina-prelaunch__content h1 { font-size: clamp(27px, 4vw, 45px) !important; }
            }
        </style>

        {#/*============================================================================
            #Javascript: Needed before HTML loads
        ==============================================================================*/#}

        {# Defines if async JS will be used by using script_tag(true) #}

        {% set async_js = true %}

        {# Defines the usage of jquery loaded below, if nojquery = true is deleted it will fallback to jquery 1.5 #}

        {% set nojquery = true %}

        {# Jquery async by adding script_tag(true) #}

        {{ '//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js' | script_tag(true) }}

        {# Loads private Tienda Nube JS #}

        {% head_content %}

        {# Structured data to provide information for Google about the page content #}

        {{ component('structured-data') }}

    </head>
    <body class="sulmina-site sulmina-prelaunch-mode body-password {% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}">

        {# Back to admin bar #}

        {{back_to_admin}}

        {% include "snipplets/home/prelaunch.tpl" %}

        {# Javascript needed to footer logos lazyload #}

        <script type="text/javascript">

            {# Libraries that do NOT depend on other libraries, e.g: Jquery #}

            {% include "static/js/external-no-dependencies.js.tpl" %}

            LS.ready.then(function(){
                jQueryNuvem('.js-password-view').on("click", function (e) {
                    jQueryNuvem(e.currentTarget).toggleClass('password-view');

                    if(jQueryNuvem(e.currentTarget).hasClass('password-view')){
                        jQueryNuvem(e.currentTarget).parent().find(".js-password-input").attr('type', '');
                        jQueryNuvem(e.currentTarget).find(".js-eye-open, .js-eye-closed").toggle();
                    } else {
                        jQueryNuvem(e.currentTarget).parent().find(".js-password-input").attr('type', 'password');
                        jQueryNuvem(e.currentTarget).find(".js-eye-open, .js-eye-closed").toggle();
                    }
                });
            });

        </script>

        <script src="{{ 'js/sulmina.js' | static_url }}?v=20260920-09" defer></script>

        {# Google survey JS for Tienda Nube Survey #}

        {{ component('google-survey') }}

    </body>
</html>
