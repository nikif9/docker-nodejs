import React, { useState } from 'react';
import './App.css';

function App() {
  // fibNumber – число для вычисления Фибоначчи, по умолчанию 35
  const [fibNumber, setFibNumber] = useState(35);
  const [result, setResult] = useState(null);
  const [loading, setLoading] = useState(false);

  const handleCompute = async () => {
    setLoading(true);
    try {
      const response = await fetch(`/api/compute?n=${fibNumber}`);
      const data = await response.json();
      setResult(data);
      randomizeFibNumber();
    } catch (error) {
      console.error("Ошибка при вычислении:", error);
    }
    setLoading(false);
  };

  const randomizeFibNumber = () => {
    // Генерируем случайное число от 1 до 50
    const randomNumber = Math.floor(Math.random() * 50) + 1;
    setFibNumber(randomNumber);
  };

  return (
    <div className="App" style={{ textAlign: 'center', marginTop: '50px' }}>
      <h1>Вычислительное приложение</h1>
      
      {/* Отображаем текущее число и кнопку для рандомизации */}
      <div style={{ marginBottom: '20px' }}>
        <p>Текущее число: <strong>{fibNumber}</strong></p>
      </div>
      
      {/* Кнопка для вычисления Фибоначчи */}
      <button onClick={handleCompute} disabled={loading}>
        {loading ? 'Выполнение...' : `Вычислить Fibonacci(${fibNumber})`}
      </button>
      
      {result && (
        <div style={{ marginTop: '20px' }}>
          <p>Fibonacci({result.n}) = {result.result}</p>
        </div>
      )}
    </div>
  );
}

export default App;
