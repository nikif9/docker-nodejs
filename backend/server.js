const express = require('express');
const path = require('path');

const app = express();
const port = process.env.PORT || 3000;

// Пример произвольной вычислительной задачи: рекурсивное вычисление числа Фибоначчи
function fibonacci(n) {
  if (n <= 1) return n;
  let a = 0, b = 1;
  for (let i = 2; i <= n; i++) {
    [a, b] = [b, a + b];
  }
  return b;
}

// API-эндпоинт для вычисления
app.get('/api/compute', (req, res, next) => {
  try {
    const n = parseInt(req.query.n);
    if (isNaN(n)) throw new Error('Некорректное значение n');

    const result = fibonacci(n);
    res.json({ n, result });
  } catch (error) {
    next(error);
  }
});

// Отдаём статические файлы фронтенда (собранного в production-режиме)
app.use(express.static(path.join(__dirname, '../frontend/build')));

// Любой нераспознанный запрос возвращаем index.html (поддержка client-side роутинга)
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '../frontend/build', 'index.html'));
});

// Глобальный обработчик ошибок
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: err.message || 'Внутренняя ошибка сервера' });
});

app.listen(port, () => {
  console.log(`Сервер запущен на порту ${port}`);
});
