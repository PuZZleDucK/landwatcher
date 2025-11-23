import { useState } from 'react'
import './App.css'
import Nav from './Nav'
import Tools from './Tools'
import Listings from './Listings'
import Footer from './Footer'

function App() {
  const [count, setCount] = useState(0)
  const [filters, setFilters] = useState({});

  return (
    <>
      <Nav />
      <Tools filters={filters} setFilters={setFilters} />
      <Listings filters={filters} setFilters={setFilters} />
      <Footer />
    </>
  )
}

export default App
