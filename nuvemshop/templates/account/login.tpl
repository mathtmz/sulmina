<main class="sulmina-help-page sulmina-account-page sulmina-account-page--login">
	<section class="sulmina-help-page__hero" aria-labelledby="sulmina-account-login-title">
		<div class="sulmina-help-page__hero-inner">
			<p class="sulmina-help-page__eyebrow">Área do cliente</p>
			<h1 id="sulmina-account-login-title">Entrar na sua conta</h1>
			<span class="sulmina-help-page__hero-line" aria-hidden="true"></span>
		</div>
	</section>

	<section class="sulmina-help-page__body sulmina-account-page__body account-page">
		<div class="container">
			<div class="sulmina-account-page__layout">
				<aside class="sulmina-account-page__intro">
					<p class="sulmina-account-page__intro-eyebrow">Sua jornada continua por aqui</p>
					<h2>Bem-vindo de volta.</h2>
					<p>Acesse seus pedidos, acompanhe suas compras e mantenha seus dados sempre por perto.</p>
					<div class="sulmina-account-page__note">
						<span aria-hidden="true">◆</span>
						<p>Ainda não tem uma conta? Você pode criar a sua depois do login.</p>
					</div>
				</aside>

				<div class="sulmina-account-page__form-panel">

				{{ component('forms/account/login' , {
					validation_classes: {
						link: 'btn-link font-small ml-1',
						text_align: 'text-center',
						text_size: 'font-small',
					},
					spacing_classes: {
						top_2x: 'mt-2',
						bottom_2x: 'mb-2',
						bottom_3x: 'mb-3',
						bottom_4x: 'mb-4',
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
						submit_spinner: 'icon-inline icon-spin ml-2'
					}})
				}}

				</div>
		</div>
	</div>
</section>
</main>
