var checkbox = document.querySelector('input[name=checkbox]');

const html = document.querySelector('.html');

checkbox.addEventListener('change', function () {
  if (this.checked) {
    html.classList.add('dark');
    console.log('Checked');
  } else {
    html.classList.remove('dark');
    console.log('Not Checked');
  }
});
