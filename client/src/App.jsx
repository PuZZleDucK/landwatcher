import { useState } from 'react'
import './App.css'
import Nav from './Nav'
import Tools from './Tools'
import Listings from './Listings'
import Footer from './Footer'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <Nav />
      <Tools />
      <Listings />
      <Footer />
    </>
  )
}

export default App
