<?php
$pageTitle = 'المساعد الذكي';
require_once __DIR__ . '/config/config.php';
requireLogin();
require_once __DIR__ . '/includes/header.php';
?>

<div class="chat-container">
  <div class="chat-header">
    <h2>🤖 مساعد علمني الذكي</h2>
    <p>مساعدك في تعلم اللغات - اسألني أي شيء عن القواعد، الترجمة، أو نصائح التعلم.</p>
  </div>

  <div class="chat-messages" id="chatMessages">
    <div class="msg msg-bot">مرحباً 👋 أنا مساعد علمني الذكي. كيف أقدر أساعدك في رحلتك التعليمية اليوم؟</div>
  </div>

  <div class="chat-suggestions">
    <span class="suggestion-chip" onclick="setMsg(this.innerText)">شرح المضارع البسيط</span>
    <span class="suggestion-chip" onclick="setMsg(this.innerText)">نصائح لتعلم لغة جديدة</span>
    <span class="suggestion-chip" onclick="setMsg(this.innerText)">ترجم: السلام عليكم</span>
    <span class="suggestion-chip" onclick="setMsg(this.innerText)">كيف أحفظ المفردات؟</span>
    <span class="suggestion-chip" onclick="setMsg(this.innerText)">ما الفرق بين will و going to؟</span>
  </div>

  <form class="chat-input-row" id="chatForm" onsubmit="sendMessage(event)">
    <input type="text" id="chatInput" placeholder="اكتب سؤالك هنا..." autocomplete="off" required>
    <button type="submit" class="btn">إرسال</button>
  </form>
</div>

<script>
function setMsg(text){ document.getElementById('chatInput').value = text; }

async function sendMessage(e){
  e.preventDefault();
  const input = document.getElementById('chatInput');
  const text = input.value.trim();
  if (!text) return;
  addMsg(text, 'user');
  input.value = '';

  // إرسال للسيرفر
  try {
    const res = await fetch('<?= SITE_URL ?>/api/chat.php', {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({message: text})
    });
    const data = await res.json();
    setTimeout(() => addMsg(data.reply, 'bot'), 500);
  } catch(err) {
    addMsg('عذراً، حصل خطأ. حاول مرة أخرى.', 'bot');
  }
}

function addMsg(text, who){
  const box = document.getElementById('chatMessages');
  const div = document.createElement('div');
  div.className = 'msg msg-' + who;
  div.innerText = text;
  box.appendChild(div);
  box.scrollTop = box.scrollHeight;
}
</script>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
