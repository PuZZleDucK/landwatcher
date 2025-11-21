import { useState } from 'react'
import reactLogo from './assets/react.svg'
import './App.css'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <div>
        <img src={reactLogo} className="logo react" alt="React logo" />
      </div>
      <h1>LandWatcher</h1>
      <div className="card">
        <p>
          Search lands. Filter lands. Watch land.
        </p>
        <p className="read-the-docs">
          A simple react interface to a rails backend.
        </p>
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>
      </div>
    </>
  )
}

export default App
