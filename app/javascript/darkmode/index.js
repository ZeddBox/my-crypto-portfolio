window.onload = function () {
  const themeToggler = document.querySelector('#theme-toggler');
  const currentTheme = localStorage.getItem('theme');
  const pageTheme = document.querySelector('.html');

  let isDark = true;

  // if (currentTheme == 'dark') {
  //   pageTheme.classList.add('dark');
  //   themeToggler.checked = true;
  // }

  if (currentTheme == 'dark') {
    pageTheme.classList.add('dark');
    themeToggler.innerText = '🌞';
  } else {
    themeToggler.innerText = '🌚';
  }

  function themeMode() {
    console.log('clicked');
    isDark = !isDark;
    isDark ? (themeToggler.innerText = '🌞') : (themeToggler.innerText = '🌚');
    // isDark ? (themeToggler.checked = true) : (themeToggler.checked = false);
    pageTheme.classList.toggle('dark');

    let theme = 'light';
    if (pageTheme.classList.contains('dark')) {
      theme = 'dark';
    }
    localStorage.setItem('theme', theme);
  }

  themeToggler.addEventListener('click', themeMode);

  // checkbox.addEventListener('change', function () {
  //   if (this.checked) {
  //     html.classList.add('dark');
  //     console.log('Checked');
  //   } else {
  //     html.classList.remove('dark');
  //     console.log('Not Checked');
  //   }
  // });
};
