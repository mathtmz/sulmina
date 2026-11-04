<main class="sulmina-help-page sulmina-account-page sulmina-account-page--register">
	<section class="sulmina-help-page__hero" aria-labelledby="sulmina-account-register-title">
		<div class="sulmina-help-page__hero-inner">
			<p class="sulmina-help-page__eyebrow">Área do cliente</p>
			<h1 id="sulmina-account-register-title">Criar sua conta</h1>
			<span class="sulmina-help-page__hero-line" aria-hidden="true"></span>
		</div>
	</section>

	<section class="sulmina-help-page__body sulmina-account-page__body account-page">
		<div class="container">
			<div class="sulmina-account-page__layout">
				<aside class="sulmina-account-page__intro">
					<p class="sulmina-account-page__intro-eyebrow">Um lugar para sua próxima compra</p>
					<h2>Mais simples, daqui pra frente.</h2>
					<p>Crie seu espaço na Sulmina para acompanhar pedidos e comprar os produtos da nossa terra com mais tranquilidade.</p>
					<div class="sulmina-account-page__note">
						<span aria-hidden="true">◆</span>
						<p>Você só precisa se cadastrar uma vez. Depois, seus dados ficam por perto.</p>
					</div>
				</aside>

				<div class="sulmina-account-page__form-panel">
					{{ component('nubesdk-slot', { type: "before_register_form" }) }}

					<p class="sulmina-account-page__form-intro">Compre mais rápido e acompanhe seus pedidos em um só lugar.</p>

					{{ component('forms/account/register' , {
						validation_classes: {
							link: 'btn-link font-small ml-1',
							text_align: 'text-center',
							text_size: 'font-small',
						},
						spacing_classes: {
							top_2x: 'mt-2',
							bottom_2x: 'mb-2',
							bottom_3x: 'mb-3',
						},
						form_classes: {
							facebook_login: 'btn btn-secondary d-block mb-4',
							password_toggle: 'btn',
							input_help_align: 'text-right',
							input_help_link: 'btn-link btn-link font-small mb-2 mr-1',
							help_align: 'text-center',
							help_text_size: 'font-small',
							help_link: 'btn-link btn-link font-small mb-2 ml-1',
							submit: 'btn btn-primary btn-big btn-block',
							submit_spinner: 'icon-inline icon-spin ml-2',
							input_error: 'notification-left',
						}})
					}}

					{{ component('nubesdk-slot', { type: "after_register_form" }) }}
				</div>
			</div>
		</div>
	</section>
</main>
