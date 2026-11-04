(function () {
    'use strict';

    /* Small brand-layer enhancements only. Nuvemshop's store.js owns cart, variants,
       search, checkout and all commerce events. */
    document.querySelectorAll('.sulmina-nav__list a').forEach(function (link) {
        if (link.href === window.location.href) {
            link.classList.add('selected');
        }
    });

    var prelaunchPage = document.querySelector('.sulmina-prelaunch-page');
    if (prelaunchPage) {
        var prelaunchStorageKey = 'sulmina-prelaunch-newsletter-subscribed';
        var prelaunchForm = prelaunchPage.querySelector('form[data-store="newsletter-form"]');
        var prelaunchTitle = prelaunchPage.querySelector('.sulmina-prelaunch__signup-title');
        var prelaunchNote = prelaunchPage.querySelector('.sulmina-prelaunch__note');
        var serverConfirmed = prelaunchPage.getAttribute('data-newsletter-success') === 'true';
        var locallyConfirmed = false;

        try {
            locallyConfirmed = window.localStorage.getItem(prelaunchStorageKey) === '1';
            if (serverConfirmed) {
                window.localStorage.setItem(prelaunchStorageKey, '1');
                locallyConfirmed = true;
            }
        } catch (error) {
            locallyConfirmed = serverConfirmed;
        }

        if (locallyConfirmed) {
            if (prelaunchForm) prelaunchForm.hidden = true;
            if (prelaunchTitle) prelaunchTitle.hidden = true;
            if (prelaunchNote) prelaunchNote.hidden = true;

            if (!serverConfirmed) {
                var persistentSuccess = prelaunchPage.querySelector('[data-prelaunch-persistent-success]');
                if (persistentSuccess) persistentSuccess.hidden = false;
            }
        }
    }

    /* Give short, editor-managed section labels in legal pages an editorial
       hierarchy without taking content management away from Nuvemshop. */
    var helpPage = document.querySelector('.sulmina-help-page--terms, .sulmina-help-page--returns');
    if (helpPage) {
        var helpContent = helpPage.querySelector('.sulmina-help-page__content');
        if (helpContent) {
            Array.prototype.slice.call(helpContent.children).forEach(function (element) {
                var text = (element.textContent || '').replace(/\s+/g, ' ').trim();
                var next = element.nextElementSibling;
                var nextText = next ? (next.textContent || '').replace(/\s+/g, ' ').trim() : '';
                var isShortLabel = element.tagName === 'P' && text && text.length <= 48 &&
                    !element.querySelector('a, img, strong, em, ul, ol') && next &&
                    next.tagName === 'P' && nextText;
                if (isShortLabel) element.classList.add('sulmina-help-subheading');
            });
        }
    }

    var lojaPage = document.querySelector('.sulmina-loja-page');
    if (!lojaPage) return;

    var cards = Array.prototype.slice.call(lojaPage.querySelectorAll('.sulmina-home-product-card'));
    var filterInputs = Array.prototype.slice.call(lojaPage.querySelectorAll('[data-loja-filter-group]'));
    var emptyState = lojaPage.querySelector('.sulmina-loja-no-results');

    function applyLojaFilters() {
        var selected = { roast: [], notes: [], producer: [], grind: [] };
        filterInputs.forEach(function (input) {
            if (input.checked && selected[input.dataset.lojaFilterGroup]) {
                selected[input.dataset.lojaFilterGroup].push(input.value);
            }
        });

        var visibleCards = 0;
        cards.forEach(function (card) {
            var matches = Object.keys(selected).every(function (group) {
                var values = selected[group];
                if (!values.length) return true;
                var cardValues = (card.getAttribute('data-sulmina-' + group) || '').split(' ');
                return values.some(function (value) { return cardValues.indexOf(value) !== -1; });
            });
            card.hidden = !matches;
            if (matches) visibleCards += 1;
        });

        if (emptyState) emptyState.hidden = visibleCards > 0;
    }

    lojaPage.addEventListener('change', function (event) {
        if (event.target && event.target.matches('[data-loja-filter-group]')) {
            var filterGroup = event.target.getAttribute('data-loja-filter-group');
            if ((filterGroup === 'roast' || filterGroup === 'grind') && event.target.checked) {
                filterInputs.forEach(function (input) {
                    if (input !== event.target && input.getAttribute('data-loja-filter-group') === filterGroup) {
                        input.checked = false;
                    }
                });
            }
            applyLojaFilters();
        }
    });
    lojaPage.addEventListener('input', function (event) {
        if (event.target && event.target.matches('[data-loja-filter-group]')) {
            applyLojaFilters();
        }
    });
    applyLojaFilters();
})();
