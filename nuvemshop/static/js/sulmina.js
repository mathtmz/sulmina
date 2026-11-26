(function () {
    'use strict';

    /* Small brand-layer enhancements only. Nuvemshop's store.js owns cart, variants,
       search, checkout and all commerce events. */

    function sulminaRawCents(value) {
        var parsed = parseInt(String(value || '').replace(/[^0-9-]/g, ''), 10);
        return isNaN(parsed) ? 0 : parsed;
    }

    function sulminaMoney(cents, currency) {
        try {
            return new Intl.NumberFormat('pt-BR', {
                style: 'currency',
                currency: currency || 'BRL'
            }).format(cents / 100);
        } catch (error) {
            return 'R$ ' + (cents / 100).toFixed(2).replace('.', ',');
        }
    }

    function sulminaMoneyCents(value) {
        var text = String(value || '').replace(/\u00a0/g, ' ').trim();
        var currencyIndex = text.lastIndexOf('R$');
        if (currencyIndex !== -1) text = text.slice(currencyIndex + 2);
        var numeric = text.replace(/[^0-9,.-]/g, '');
        if (!numeric) return null;

        var comma = numeric.lastIndexOf(',');
        var dot = numeric.lastIndexOf('.');
        if (comma > dot) {
            numeric = numeric.replace(/\./g, '').replace(',', '.');
        } else if (dot !== -1) {
            numeric = numeric.replace(/,/g, '');
        }

        var amount = parseFloat(numeric);
        return isNaN(amount) ? null : Math.round(Math.abs(amount) * 100);
    }

    function sulminaSetText(element, value) {
        if (element && element.textContent !== value) element.textContent = value;
    }

    var sulminaCartQuantityPending = false;
    var sulminaCartQuantityStartedAt = 0;
    var sulminaCartFinancialChangedAt = 0;
    var sulminaCartInitialFinancialState = '';
    var sulminaCartLatestFinancialState = '';
    var sulminaCartQuantityTimer = null;
    var sulminaCartUnconfirmedFinancialState = null;

    function sulminaCartFinancialState() {
        return Array.prototype.slice.call(document.querySelectorAll(
            '.sulmina-native-total-price, .sulmina-native-shipping-price, .js-cart-subtotal[data-priceraw], .js-cart-discount[data-priceraw]'
        )).map(function (element) {
            return (element.getAttribute('data-priceraw') || element.textContent || '').replace(/\s+/g, ' ').trim();
        }).join('|');
    }

    function sulminaCartRequestIsBusy() {
        return Array.prototype.slice.call(document.querySelectorAll('.js-cart-input-spinner')).some(function (spinner) {
            var style = window.getComputedStyle(spinner);
            return style.display !== 'none' && style.visibility !== 'hidden' && spinner.getClientRects().length > 0;
        });
    }

    function scheduleSulminaCartQuantityCheck() {
        if (sulminaCartQuantityTimer) window.clearTimeout(sulminaCartQuantityTimer);
        sulminaCartQuantityTimer = window.setTimeout(checkSulminaCartQuantityUpdate, 100);
    }

    function beginSulminaCartQuantityUpdate() {
        if (!sulminaCartQuantityPending) {
            sulminaCartQuantityPending = true;
            sulminaCartQuantityStartedAt = Date.now();
            sulminaCartFinancialChangedAt = sulminaCartQuantityStartedAt;
            sulminaCartInitialFinancialState = sulminaCartFinancialState();
            sulminaCartLatestFinancialState = sulminaCartInitialFinancialState;
        }
        scheduleSulminaCartQuantityCheck();
    }

    function checkSulminaCartQuantityUpdate() {
        if (!sulminaCartQuantityPending) return;

        var now = Date.now();
        var state = sulminaCartFinancialState();
        if (state !== sulminaCartLatestFinancialState) {
            sulminaCartLatestFinancialState = state;
            sulminaCartFinancialChangedAt = now;
        }

        var elapsed = now - sulminaCartQuantityStartedAt;
        var quietTime = now - sulminaCartFinancialChangedAt;
        var financialValuesUpdated = state !== sulminaCartInitialFinancialState;
        var requestIsBusy = sulminaCartRequestIsBusy();
        var financialValuesSettled = !requestIsBusy && financialValuesUpdated && quietTime >= 280;
        var safetyTimeoutReached = elapsed >= 5000;

        if (financialValuesSettled || safetyTimeoutReached) {
            sulminaCartQuantityPending = false;
            sulminaCartQuantityTimer = null;
            if (financialValuesSettled) {
                sulminaCartUnconfirmedFinancialState = null;
                updateSulminaCartSummaries();
            } else {
                sulminaCartUnconfirmedFinancialState = state;
            }
            return;
        }

        scheduleSulminaCartQuantityCheck();
    }

    function queueSulminaCartSummaryUpdate() {
        if (sulminaCartQuantityPending) {
            scheduleSulminaCartQuantityCheck();
            return;
        }
        if (sulminaCartUnconfirmedFinancialState !== null) {
            if (sulminaCartFinancialState() === sulminaCartUnconfirmedFinancialState) return;
            sulminaCartUnconfirmedFinancialState = null;
        }
        if (sulminaCartSummaryUpdateQueued) return;
        sulminaCartSummaryUpdateQueued = true;
        window.setTimeout(function () {
            sulminaCartSummaryUpdateQueued = false;
            if (!sulminaCartQuantityPending) updateSulminaCartSummaries();
        }, 40);
    }

    function updateSulminaCartSummaries() {
        if (sulminaCartQuantityPending) return;
        Array.prototype.slice.call(document.querySelectorAll('[data-sulmina-cart-summary]')).forEach(function (summary) {
            var surface = summary.closest('#shoppingCartPage, .js-ajax-cart-panel') || document;
            var wrapper = summary.parentElement;
            var nativeTotal = wrapper ? wrapper.querySelector('.sulmina-native-total-price') : null;
            var nativeShipping = wrapper ? wrapper.querySelector('.sulmina-native-shipping-price') : null;
            var currency = summary.getAttribute('data-cart-currency') || 'BRL';
            var subtotalCents = sulminaRawCents(summary.getAttribute('data-cart-subtotal'));
            var itemFullSubtotalCents = 0;
            var hasCartItems = false;
            var lineItems = [];

            Array.prototype.slice.call(surface.querySelectorAll('.js-cart-item[data-sulmina-compare-subtotal]')).forEach(function (item) {
                if (item.getAttribute('data-gift') === 'true') return;
                var compareUnitCents = sulminaRawCents(item.getAttribute('data-sulmina-compare-unit'));
                var quantityInput = item.querySelector('.js-cart-quantity-input');
                var quantity = quantityInput ? parseInt(quantityInput.value, 10) : parseInt(item.getAttribute('data-sulmina-quantity'), 10);
                if (isNaN(quantity) || quantity < 1) quantity = 1;
                var compareCents = compareUnitCents > 0
                    ? compareUnitCents * quantity
                    : sulminaRawCents(item.getAttribute('data-sulmina-compare-subtotal'));
                itemFullSubtotalCents += compareCents;
                lineItems.push({ element: item, fullSubtotal: compareCents });
                hasCartItems = true;
            });

            /* Rebuild the pre-discount subtotal from the catalog compare price and the
               live quantity input. Cart line totals can remain stale during AJAX updates. */
            var fullSubtotalCents = hasCartItems ? itemFullSubtotalCents : subtotalCents;
            var shippingText = nativeShipping ? nativeShipping.textContent.replace(/\s+/g, ' ').trim() : '';
            var parsedShippingCents = sulminaMoneyCents(shippingText);
            var freeShipping = shippingText
                ? (/gr[aá]tis/i.test(shippingText) || parsedShippingCents === 0)
                : summary.getAttribute('data-cart-free-shipping') === 'true';
            var shippingCents = freeShipping ? 0 : parsedShippingCents;
            if (shippingCents === null) shippingCents = sulminaRawCents(summary.getAttribute('data-cart-shipping'));

            var fallbackTotalCents = sulminaRawCents(summary.getAttribute('data-cart-total'));
            var nativeTotalText = nativeTotal ? nativeTotal.textContent.replace(/\s+/g, ' ').trim() : '';
            var totalCents = sulminaMoneyCents(nativeTotalText);
            if (totalCents === null) totalCents = fallbackTotalCents;

            var netItemsCents = Math.max(totalCents - shippingCents, 0);
            var discountCents = Math.max(fullSubtotalCents - netItemsCents, 0);

            var remainingDiscountCents = discountCents;
            lineItems.forEach(function (line, index) {
                var lineDiscountCents = 0;
                if (line.fullSubtotal > 0 && fullSubtotalCents > 0) {
                    lineDiscountCents = index === lineItems.length - 1
                        ? Math.min(remainingDiscountCents, line.fullSubtotal)
                        : Math.min(Math.round(discountCents * line.fullSubtotal / fullSubtotalCents), remainingDiscountCents, line.fullSubtotal);
                }
                remainingDiscountCents = Math.max(remainingDiscountCents - lineDiscountCents, 0);
                var lineFinalCents = Math.max(line.fullSubtotal - lineDiscountCents, 0);
                var linePercentage = line.fullSubtotal > 0 ? Math.round(lineDiscountCents * 100 / line.fullSubtotal) : 0;
                var compareText = sulminaMoney(line.fullSubtotal, currency);

                Array.prototype.slice.call(line.element.querySelectorAll('.js-cart-item-subtotal-compare-price')).forEach(function (price) {
                    sulminaSetText(price, compareText);
                    price.setAttribute('data-component-value', compareText);
                });
                Array.prototype.slice.call(line.element.querySelectorAll('.js-cart-item-subtotal-compare-price-container')).forEach(function (container) {
                    container.style.display = lineDiscountCents > 0 ? '' : 'none';
                });
                Array.prototype.slice.call(line.element.querySelectorAll('[data-sulmina-line-discount-row]')).forEach(function (row) {
                    row.style.display = lineDiscountCents > 0 ? '' : 'none';
                });
                Array.prototype.slice.call(line.element.querySelectorAll('[data-sulmina-line-discount-label]')).forEach(function (label) {
                    sulminaSetText(label, 'Desconto (' + linePercentage + '%)');
                });
                Array.prototype.slice.call(line.element.querySelectorAll('[data-sulmina-line-discount-value]')).forEach(function (amount) {
                    sulminaSetText(amount, '-' + sulminaMoney(lineDiscountCents, currency));
                });
                Array.prototype.slice.call(line.element.querySelectorAll('[data-sulmina-line-final-value]')).forEach(function (amount) {
                    amount.style.display = lineDiscountCents > 0 ? '' : 'none';
                    var finalText = sulminaMoney(lineFinalCents, currency);
                    var finalAmount = amount.querySelector('[data-sulmina-line-final-amount]');
                    if (finalAmount) {
                        sulminaSetText(finalAmount, finalText);
                    } else {
                        sulminaSetText(amount, 'Preço final: ' + finalText);
                    }
                    amount.setAttribute('data-component-value', finalText);
                });
            });

            sulminaSetText(summary.querySelector('[data-sulmina-summary-subtotal]'), sulminaMoney(fullSubtotalCents, currency));
            sulminaSetText(summary.querySelector('[data-sulmina-summary-discount]'), discountCents > 0 ? '-' + sulminaMoney(discountCents, currency) : sulminaMoney(0, currency));
            var discountRow = summary.querySelector('.sulmina-cart-summary__row--discount');
            if (discountRow) discountRow.style.display = discountCents > 0 ? '' : 'none';

            var shippingLabel;
            if (freeShipping) {
                shippingLabel = 'Grátis';
            } else if (shippingText) {
                shippingLabel = shippingText;
            } else if (shippingCents > 0) {
                shippingLabel = sulminaMoney(shippingCents, currency);
            } else {
                shippingLabel = summary.getAttribute('data-cart-calculator-enabled') === 'true' ? 'Calcule para ver' : 'Calculado no checkout';
            }
            sulminaSetText(summary.querySelector('[data-sulmina-summary-shipping]'), shippingLabel);
            sulminaSetText(summary.querySelector('[data-sulmina-summary-total]'), nativeTotalText || sulminaMoney(totalCents, currency));
        });
    }

    updateSulminaCartSummaries();
    if (window.MutationObserver && document.body) {
        var sulminaCartSummaryUpdateQueued = false;
        var sulminaCartSummaryObserver = new MutationObserver(function () {
            queueSulminaCartSummaryUpdate();
        });
        sulminaCartSummaryObserver.observe(document.body, {
            childList: true,
            characterData: true,
            subtree: true,
            attributes: true,
            attributeFilter: [
                'data-sulmina-compare-subtotal', 'data-sulmina-current-subtotal',
                'data-sulmina-compare-unit', 'data-sulmina-quantity',
                'data-cart-subtotal', 'data-cart-total', 'data-cart-shipping',
                'data-cart-promotion-discount', 'data-cart-free-shipping'
            ]
        });
        document.body.addEventListener('focusout', function (event) {
            if (event.target && event.target.matches('.js-cart-quantity-input')) {
                beginSulminaCartQuantityUpdate();
            }
        }, true);
        document.body.addEventListener('click', function (event) {
            if (event.target && event.target.closest('.js-cart-quantity-btn, [data-component="line-item.remove"]')) {
                beginSulminaCartQuantityUpdate();
            }
        }, true);
    }

    document.querySelectorAll('.sulmina-nav__list a').forEach(function (link) {
        if (link.href === window.location.href) {
            link.classList.add('selected');
        }
    });

    document.querySelectorAll('[data-sulmina-products-carousel]').forEach(function (carousel) {
        var track = carousel.querySelector('[data-sulmina-products-track]');
        var slides = Array.prototype.slice.call(carousel.querySelectorAll('.sulmina-product-slide'));
        var previous = carousel.querySelector('[data-sulmina-products-previous]');
        var next = carousel.querySelector('[data-sulmina-products-next]');
        var status = carousel.querySelector('[data-sulmina-products-status]');

        if (!track || slides.length < 2) return;

        /* Mix the displayed order on each home-page entry. Move each slide
           wrapper as a unit so the product card and its inline data script stay together. */
        for (var index = slides.length - 1; index > 0; index--) {
            var randomIndex = Math.floor(Math.random() * (index + 1));
            var temporarySlide = slides[index];
            slides[index] = slides[randomIndex];
            slides[randomIndex] = temporarySlide;
        }
        slides.forEach(function (slide, slideIndex) {
            track.appendChild(slide);
            slide.setAttribute('aria-label', (slideIndex + 1) + ' de ' + slides.length);
        });
        track.scrollLeft = 0;

        if (slides.length <= 4 || !previous || !next) return;

        function itemStep() {
            var style = window.getComputedStyle(track);
            var gap = parseFloat(style.columnGap || style.gap) || 0;
            return slides[0].getBoundingClientRect().width + gap;
        }

        function visibleCount() {
            return Math.max(1, Math.round(track.clientWidth / itemStep()));
        }

        function updateStatus() {
            var step = itemStep();
            var first = Math.min(Math.round(track.scrollLeft / step), Math.max(slides.length - visibleCount(), 0));
            var last = Math.min(first + visibleCount(), slides.length);
            if (status) status.textContent = (first + 1) + '–' + last + ' de ' + slides.length;
        }

        function move(direction) {
            var pageDistance = track.clientWidth;
            var maxScroll = Math.max(track.scrollWidth - track.clientWidth, 0);
            var atStart = track.scrollLeft <= 2;
            var atEnd = track.scrollLeft >= maxScroll - 2;
            var target;

            if (direction > 0) {
                target = atEnd ? 0 : Math.min(track.scrollLeft + pageDistance, maxScroll);
            } else {
                target = atStart ? maxScroll : Math.max(track.scrollLeft - pageDistance, 0);
            }

            track.scrollTo({
                left: target,
                behavior: window.matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth'
            });
        }

        previous.addEventListener('click', function () { move(-1); });
        next.addEventListener('click', function () { move(1); });
        track.addEventListener('scroll', updateStatus, { passive: true });
        window.addEventListener('resize', updateStatus);
        updateStatus();
    });

    document.querySelectorAll('[data-announcement-carousel]').forEach(function (carousel) {
        var messages = Array.prototype.slice.call(carousel.querySelectorAll('[data-announcement-message]'));
        var status = carousel.querySelector('[data-announcement-status]');
        var previous = carousel.querySelector('[data-announcement-previous]');
        var next = carousel.querySelector('[data-announcement-next]');
        var current = 0;
        var timer = null;

        if (messages.length < 2) return;

        function showMessage(index) {
            current = (index + messages.length) % messages.length;
            messages.forEach(function (message, messageIndex) {
                message.hidden = messageIndex !== current;
            });
            if (status) status.textContent = 'Mensagem ' + (current + 1) + ' de ' + messages.length;
        }

        function stopRotation() {
            if (timer) {
                window.clearInterval(timer);
                timer = null;
            }
        }

        function startRotation() {
            stopRotation();
            if (!window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
                timer = window.setInterval(function () { showMessage(current + 1); }, 6000);
            }
        }

        if (previous) previous.addEventListener('click', function () { showMessage(current - 1); startRotation(); });
        if (next) next.addEventListener('click', function () { showMessage(current + 1); startRotation(); });
        carousel.addEventListener('mouseenter', stopRotation);
        carousel.addEventListener('mouseleave', startRotation);
        carousel.addEventListener('focusin', stopRotation);
        carousel.addEventListener('focusout', function (event) {
            if (!carousel.contains(event.relatedTarget)) startRotation();
        });
        showMessage(0);
        startRotation();
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

    /* Show the 3+ launch price from the catalog's full price on product pages.
       The cart remains authoritative for the order discount; this keeps the
       displayed per-unit price consistent before the customer adds the item. */
    var productForm = document.querySelector('.sulmina-product-form');
    if (productForm) {
        var productPriceRegion = productForm.querySelector('.js-price-container');
        var productQuantityInput = productForm.querySelector('.js-quantity-input');
        var productPromoSummary = productForm.querySelector('[data-sulmina-product-promo-summary]');
        var productPromoDiscountLabel = productForm.querySelector('[data-sulmina-product-promo-discount-label]');
        var productPromoDiscountValue = productForm.querySelector('[data-sulmina-product-promo-discount-value]');
        var productPromoOriginalPrice = '';
        var productPromoOriginalCompare = '';
        var productPromoOriginalCompareDisplay = '';
        var productPromoRenderedPrice = null;
        var productPromoRenderedCompare = null;
        var productPromoActive = false;
        var productPromoTimer = null;

        function scheduleProductPromoPriceUpdate() {
            if (productPromoTimer) window.clearTimeout(productPromoTimer);
            productPromoTimer = window.setTimeout(updateProductPromoPrice, 0);
        }

        function updateProductPromoPrice() {
            if (!productPriceRegion || !productQuantityInput || !productPromoSummary) return;

            var priceNode = productPriceRegion.querySelector('#price_display');
            var compareNode = productPriceRegion.querySelector('#compare_price_display');
            if (!priceNode) return;

            var currentPriceText = (priceNode.textContent || '').trim();
            var currentCompareText = compareNode ? (compareNode.textContent || '').trim() : '';
            var quantity = parseInt(productQuantityInput.value, 10);
            if (isNaN(quantity) || quantity < 1) quantity = 1;

            if (productPromoActive) {
                if (currentPriceText && currentPriceText !== productPromoRenderedPrice) {
                    productPromoOriginalPrice = currentPriceText;
                }
                if (compareNode && currentCompareText !== productPromoRenderedCompare) {
                    productPromoOriginalCompare = currentCompareText;
                    productPromoOriginalCompareDisplay = compareNode.style.display;
                }
            } else {
                productPromoOriginalPrice = currentPriceText;
                productPromoOriginalCompare = currentCompareText;
                productPromoOriginalCompareDisplay = compareNode ? compareNode.style.display : '';
            }

            if (quantity < 3) {
                if (productPromoActive) {
                    priceNode.textContent = productPromoOriginalPrice;
                    if (compareNode) {
                        compareNode.textContent = productPromoOriginalCompare;
                        compareNode.style.display = productPromoOriginalCompareDisplay;
                    }
                }
                productPromoActive = false;
                productPromoRenderedPrice = null;
                productPromoRenderedCompare = null;
                productPromoSummary.hidden = true;
                return;
            }

            var salePriceCents = sulminaMoneyCents(productPromoOriginalPrice);
            var comparePriceCents = sulminaMoneyCents(productPromoOriginalCompare);
            if (salePriceCents === null) return;

            var fullPriceCents = comparePriceCents !== null && comparePriceCents > salePriceCents
                ? comparePriceCents
                : salePriceCents;
            var discountCents = Math.round(fullPriceCents * 0.15);
            var finalPriceCents = Math.max(fullPriceCents - discountCents, 0);
            var fullPriceText = sulminaMoney(fullPriceCents, 'BRL');

            productPromoRenderedPrice = sulminaMoney(finalPriceCents, 'BRL');
            priceNode.textContent = productPromoRenderedPrice;
            if (compareNode) {
                productPromoRenderedCompare = fullPriceText;
                compareNode.textContent = fullPriceText;
                compareNode.style.display = 'block';
            }
            if (productPromoDiscountLabel) productPromoDiscountLabel.textContent = 'Desconto (15%)';
            if (productPromoDiscountValue) productPromoDiscountValue.textContent = '-' + sulminaMoney(discountCents, 'BRL');
            productPromoSummary.hidden = false;
            productPromoActive = true;
        }

        if (productQuantityInput) {
            productQuantityInput.addEventListener('input', scheduleProductPromoPriceUpdate);
            productQuantityInput.addEventListener('change', scheduleProductPromoPriceUpdate);
        }
        productForm.addEventListener('click', function (event) {
            if (event.target.closest('.js-quantity-up, .js-quantity-down')) scheduleProductPromoPriceUpdate();
        }, true);
        if (productPriceRegion && window.MutationObserver) {
            var productPromoObserver = new MutationObserver(scheduleProductPromoPriceUpdate);
            productPromoObserver.observe(productPriceRegion, { childList: true, characterData: true, subtree: true });
        }
        updateProductPromoPrice();
    }

    var lojaPage = document.querySelector('.sulmina-loja-page');
    if (!lojaPage) return;

    var cards = Array.prototype.slice.call(lojaPage.querySelectorAll('.sulmina-home-product-card'));
    var filterInputs = Array.prototype.slice.call(lojaPage.querySelectorAll('[data-loja-filter-group]'));
    var emptyState = lojaPage.querySelector('.sulmina-loja-no-results');
    var filterOverlay = lojaPage.querySelector('[data-loja-filter-overlay]');
    var filterPanel = lojaPage.querySelector('#sulmina-loja-filter-dialog');
    var filterOpenButton = lojaPage.querySelector('[data-loja-filter-open]');
    var filterApplyButton = lojaPage.querySelector('[data-loja-filter-apply]');
    var filterClearButton = lojaPage.querySelector('[data-loja-filter-clear]');
    var filterBadge = lojaPage.querySelector('[data-loja-filter-badge]');
    var resultCount = lojaPage.querySelector('[data-loja-results-count]');
    var filterGroups = ['roast', 'notes', 'producer', 'grind'];
    var appliedFilters = { roast: [], notes: [], producer: [], grind: [] };
    var bodyStylesBeforeFilters = null;
    var bodyScrollYBeforeFilters = 0;
    var bodyPositionLockActive = false;

    function readLojaFilters() {
        var selected = { roast: [], notes: [], producer: [], grind: [] };
        filterInputs.forEach(function (input) {
            var group = input.getAttribute('data-loja-filter-group');
            if (input.checked && selected[group]) selected[group].push(input.value);
        });
        return selected;
    }

    function setLojaFilterInputs(selected) {
        filterInputs.forEach(function (input) {
            var group = input.getAttribute('data-loja-filter-group');
            input.checked = !!(selected[group] && selected[group].indexOf(input.value) !== -1);
        });
    }

    function cardMatchesLojaFilters(card, selected, excludedGroup) {
        return filterGroups.every(function (group) {
            if (group === excludedGroup) return true;
            var values = selected[group] || [];
            if (!values.length) return true;
            var cardValues = (card.getAttribute('data-sulmina-' + group) || '').split(/\s+/);
            return values.some(function (value) { return cardValues.indexOf(value) !== -1; });
        });
    }

    function updateLojaFilterAvailability(selected) {
        Array.prototype.slice.call(lojaPage.querySelectorAll('[data-loja-filter-section]')).forEach(function (section) {
            var group = section.getAttribute('data-loja-filter-section');
            var visibleOptions = 0;
            Array.prototype.slice.call(section.querySelectorAll('[data-loja-filter-group]')).forEach(function (input) {
                var value = input.value;
                var count = cards.filter(function (card) {
                    if (!cardMatchesLojaFilters(card, selected, group)) return false;
                    var cardValues = (card.getAttribute('data-sulmina-' + group) || '').split(/\s+/);
                    return cardValues.indexOf(value) !== -1;
                }).length;
                var label = input.closest('.sulmina-loja-filter-option');
                var countLabel = label && label.querySelector('[data-loja-option-count]');
                if (countLabel) countLabel.textContent = '(' + count + ')';
                if (label) {
                    label.hidden = count === 0 && !input.checked;
                    if (!label.hidden) visibleOptions += 1;
                }
            });
            section.hidden = visibleOptions === 0;
        });
        if (filterClearButton) {
            var hasDraftSelection = filterInputs.some(function (input) { return input.checked; });
            filterClearButton.disabled = !hasDraftSelection;
        }
    }

    function selectedLojaFilterCount(selected) {
        return filterGroups.reduce(function (total, group) { return total + (selected[group] || []).length; }, 0);
    }

    function updateLojaFilterSummary(visibleCount) {
        var activeCount = selectedLojaFilterCount(appliedFilters);
        if (filterBadge) {
            filterBadge.textContent = String(activeCount);
            filterBadge.hidden = activeCount === 0;
        }
        if (filterOpenButton) {
            filterOpenButton.setAttribute('aria-label', activeCount ? 'Filtros, ' + activeCount + ' selecionados' : 'Filtros');
        }
        if (resultCount) {
            resultCount.textContent = visibleCount + (visibleCount === 1 ? ' produto' : ' produtos');
        }
    }

    function applyLojaFilters() {
        var selected = appliedFilters;
        var visibleCards = 0;
        cards.forEach(function (card) {
            var matches = cardMatchesLojaFilters(card, selected, null);
            card.hidden = !matches;
            if (matches) visibleCards += 1;
        });

        if (emptyState) emptyState.hidden = visibleCards > 0;
        updateLojaFilterSummary(visibleCards);
        updateLojaFilterAvailability(selected);
    }

    function openLojaFilters() {
        if (!filterOverlay || !filterPanel || !filterOpenButton) return;
        setLojaFilterInputs(appliedFilters);
        updateLojaFilterAvailability(appliedFilters);
        bodyScrollYBeforeFilters = window.pageYOffset || document.documentElement.scrollTop || 0;
        bodyStylesBeforeFilters = {
            overflow: document.body.style.overflow,
            position: document.body.style.position,
            top: document.body.style.top,
            left: document.body.style.left,
            right: document.body.style.right,
            width: document.body.style.width
        };
        bodyPositionLockActive = window.matchMedia && window.matchMedia('(max-width: 680px)').matches;
        filterOverlay.hidden = false;
        filterOverlay.setAttribute('aria-hidden', 'false');
        document.body.style.overflow = 'hidden';
        if (bodyPositionLockActive) {
            document.body.style.position = 'fixed';
            document.body.style.top = '-' + bodyScrollYBeforeFilters + 'px';
            document.body.style.left = '0';
            document.body.style.right = '0';
            document.body.style.width = '100%';
        }
        filterOpenButton.setAttribute('aria-expanded', 'true');
        filterPanel.focus();
    }

    function closeLojaFilters(restoreAppliedSelection) {
        if (!filterOverlay || !filterPanel) return;
        if (restoreAppliedSelection !== false) setLojaFilterInputs(appliedFilters);
        filterOverlay.hidden = true;
        filterOverlay.setAttribute('aria-hidden', 'true');
        if (bodyStylesBeforeFilters) {
            document.body.style.overflow = bodyStylesBeforeFilters.overflow;
            document.body.style.position = bodyStylesBeforeFilters.position;
            document.body.style.top = bodyStylesBeforeFilters.top;
            document.body.style.left = bodyStylesBeforeFilters.left;
            document.body.style.right = bodyStylesBeforeFilters.right;
            document.body.style.width = bodyStylesBeforeFilters.width;
        }
        if (bodyPositionLockActive) window.scrollTo(0, bodyScrollYBeforeFilters);
        bodyStylesBeforeFilters = null;
        bodyPositionLockActive = false;
        if (filterOpenButton) {
            filterOpenButton.setAttribute('aria-expanded', 'false');
            filterOpenButton.focus();
        }
    }

    if (filterOpenButton) filterOpenButton.addEventListener('click', openLojaFilters);
    if (filterOverlay) {
        filterOverlay.addEventListener('click', function (event) {
            if (event.target.closest('[data-loja-filter-dismiss]')) closeLojaFilters(true);
        });
        filterOverlay.addEventListener('change', function (event) {
            var input = event.target;
            if (!input.matches('[data-loja-filter-group]')) return;
            var group = input.getAttribute('data-loja-filter-group');
            if ((group === 'roast' || group === 'grind') && input.checked) {
                filterInputs.forEach(function (otherInput) {
                    if (otherInput !== input && otherInput.getAttribute('data-loja-filter-group') === group) otherInput.checked = false;
                });
            }
            updateLojaFilterAvailability(readLojaFilters());
        });
        filterOverlay.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
                event.preventDefault();
                closeLojaFilters(true);
                return;
            }
            if (event.key !== 'Tab' || !filterPanel) return;
            var focusable = Array.prototype.slice.call(filterPanel.querySelectorAll('button:not(:disabled), input:not(:disabled), [tabindex]:not([tabindex="-1"])')).filter(function (element) {
                return !element.closest('[hidden]') && element.offsetParent !== null;
            });
            if (!focusable.length) {
                event.preventDefault();
                filterPanel.focus();
                return;
            }
            var first = focusable[0];
            var last = focusable[focusable.length - 1];
            if (event.shiftKey && document.activeElement === first) {
                event.preventDefault();
                last.focus();
            } else if (!event.shiftKey && document.activeElement === last) {
                event.preventDefault();
                first.focus();
            }
        });
    }
    if (filterClearButton) {
        filterClearButton.addEventListener('click', function () {
            setLojaFilterInputs({ roast: [], notes: [], producer: [], grind: [] });
            updateLojaFilterAvailability(readLojaFilters());
        });
    }
    if (filterApplyButton) {
        filterApplyButton.addEventListener('click', function () {
            appliedFilters = readLojaFilters();
            applyLojaFilters();
            closeLojaFilters(false);
        });
    }

    applyLojaFilters();
})();
