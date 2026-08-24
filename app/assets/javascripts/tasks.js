document.addEventListener('change', function (e) {
  if (e.target.matches('.task-toggle')) {
    e.target.closest('form').submit();
  }
});
