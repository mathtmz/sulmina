<div class="sulmina-shipping-progress">
	{{ component('free-shipping-bar', {
		progress_bar_classes: {
			container: 'js-ship-free-rest progress-bar mt-2 mb-2 pb-1',
			title_container: 'progress-bar-title-container',
			title: 'js-ship-free-rest-message ship-free-rest-message progress-bar-title text-accent',
			track: 'bar-progress',
			fill: 'bar-progress-active transition-soft',
			check: 'bar-progress-check transition-soft',
			check_icon: 'icon-inline',
		},
		check_svg_id: 'check',
		show_check: true,
	}) }}
	<p class="sulmina-shipping-progress__offer">15% de desconto a partir de 3 produtos.</p>
</div>
