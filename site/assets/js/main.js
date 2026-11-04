// SULMINA — interações do protótipo
document.addEventListener('DOMContentLoaded', function () {

  // Menu mobile
  var btnMenu = document.querySelector('.btn-menu-mobile');
  var nav = document.querySelector('.nav-principal');
  if (btnMenu && nav) {
    btnMenu.addEventListener('click', function () {
      nav.classList.toggle('aberto');
      var aberto = nav.classList.contains('aberto');
      btnMenu.setAttribute('aria-expanded', aberto);
    });
  }

  // Accordion (FAQ, produto)
  document.querySelectorAll('.accordion-header').forEach(function (header) {
    header.addEventListener('click', function () {
      var item = header.closest('.accordion-item');
      var jaAberto = item.classList.contains('aberto');
      // fecha os irmãos do mesmo grupo, se marcado como exclusivo
      if (item.parentElement.dataset.exclusivo === 'true') {
        item.parentElement.querySelectorAll('.accordion-item.aberto').forEach(function (i) {
          if (i !== item) i.classList.remove('aberto');
        });
      }
      item.classList.toggle('aberto', !jaAberto);
    });
  });

  // Tabs (página de produto)
  document.querySelectorAll('.tabs-nav').forEach(function (nav) {
    var botoes = nav.querySelectorAll('.tab-btn');
    botoes.forEach(function (btn) {
      btn.addEventListener('click', function () {
        var alvo = btn.dataset.tab;
        botoes.forEach(function (b) { b.classList.remove('ativo'); });
        btn.classList.add('ativo');
        var paineis = document.querySelectorAll('[data-tab-painel]');
        paineis.forEach(function (p) {
          p.classList.toggle('ativo', p.dataset.tabPainel === alvo);
        });
      });
    });
  });

  // Seletor de quantidade (+/-)
  document.querySelectorAll('.seletor-qtd').forEach(function (seletor) {
    var input = seletor.querySelector('input');
    seletor.querySelectorAll('button').forEach(function (btn) {
      btn.addEventListener('click', function () {
        var atual = parseInt(input.value, 10) || 1;
        var novo = btn.dataset.acao === 'menos' ? Math.max(1, atual - 1) : atual + 1;
        input.value = novo;
        input.dispatchEvent(new Event('change'));
      });
    });
  });

  // Filtro de categorias (Jornal / Loja)
  document.querySelectorAll('.filtro-categorias').forEach(function (grupo) {
    grupo.querySelectorAll('button').forEach(function (btn) {
      btn.addEventListener('click', function () {
        grupo.querySelectorAll('button').forEach(function (b) { b.classList.remove('ativo'); });
        btn.classList.add('ativo');
      });
    });
  });

  // Checkbox de opção de pagamento — realce visual
  document.querySelectorAll('.opcao-pagamento input[type="radio"]').forEach(function (radio) {
    radio.addEventListener('change', function () {
      document.querySelectorAll('.opcao-pagamento').forEach(function (op) {
        op.classList.toggle('selecionada', op.querySelector('input').checked);
      });
    });
  });

  // Contador simples de carrinho (mock, persiste na sessão do navegador)
  var badge = document.querySelector('.badge-carrinho');
  if (badge) {
    var qtd = sessionStorage.getItem('sulmina_carrinho_qtd') || '2';
    badge.textContent = qtd;
  }
  document.querySelectorAll('[data-adicionar-carrinho]').forEach(function (btn) {
    btn.addEventListener('click', function (e) {
      e.preventDefault();
      var atual = parseInt(sessionStorage.getItem('sulmina_carrinho_qtd') || '2', 10);
      var novo = atual + 1;
      sessionStorage.setItem('sulmina_carrinho_qtd', novo);
      if (badge) badge.textContent = novo;
      var original = btn.textContent;
      btn.textContent = 'Adicionado ✓';
      setTimeout(function () { btn.textContent = original; }, 1200);
    });
  });

  // Formulários do protótipo: previne envio real
  document.querySelectorAll('form[data-prototipo]').forEach(function (form) {
    form.addEventListener('submit', function (e) {
      e.preventDefault();
      var msg = form.dataset.mensagemSucesso || 'Enviado! (protótipo — sem envio real)';
      alert(msg);
    });
  });
});
