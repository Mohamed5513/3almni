// علمني - JS عام

// تأثيرات الكويز
document.addEventListener('DOMContentLoaded', () => {
  // اختيار الإجابة
  document.querySelectorAll('.options').forEach(group => {
    group.addEventListener('change', () => {
      group.querySelectorAll('.option-label').forEach(l => l.classList.remove('selected'));
      const checked = group.querySelector('input:checked');
      if (checked) checked.closest('.option-label').classList.add('selected');
    });
  });

  // شريط تقدم الكويز
  const form = document.getElementById('quizForm');
  if (form) {
    const total = form.querySelectorAll('.question').length;
    const bar = document.getElementById('qpf');
    form.addEventListener('change', () => {
      const answered = new Set();
      form.querySelectorAll('input:checked').forEach(i => answered.add(i.name));
      if (bar) bar.style.width = ((answered.size / total) * 100) + '%';
    });

    form.addEventListener('submit', (e) => {
      const total = form.querySelectorAll('.question').length;
      const answered = new Set();
      form.querySelectorAll('input:checked').forEach(i => answered.add(i.name));
      if (answered.size < total) {
        if (!confirm('لم تجب على كل الأسئلة. هل تريد المتابعة؟')) {
          e.preventDefault();
        }
      }
    });
  }
});
