{% include 'snipplets/footer/sulmina-footer.tpl' %}

{# Final visual override kept in a fresh snippet so the storefront does not
   reuse the cached stylesheet from the previous footer implementation. #}
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
