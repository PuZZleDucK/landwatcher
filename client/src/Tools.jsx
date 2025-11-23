import { useState } from 'react'
import reactLogo from './assets/react.svg'
import './Tools.css'
function Tools( { filters, setFilters } ) {
  const handleChange = (e) => {
    const newFilters = { ...filters, [e.target.name]: e.target.value, updated: true };
    setFilters(newFilters);
  };

  return (
    <>
      <div className="tools">
        <h4>Listing Tools:</h4>
        <div className="search">
          <fieldset>
            <legend>Search</legend>
            <button>🗙</button>
            <input name="searchInput" onChange={handleChange} />
          </fieldset>
        </div>

        <div className="filters">
          <fieldset>
            <legend>Filters</legend>
            <div>Rooms: <input name="bedroomsInput" type="number" onChange={handleChange} /></div>
            <div>Type: <select name="typeSelect" onChange={handleChange}>
              <option value="any">Any</option>
              <option value="house">House</option>
              <option value="flat">Flat</option>
              <option value="mansion">Mansion</option>
              <option value="annex">Annex</option>
              <option value="villa">Villa</option>
            </select></div>
            <div>
              <div>Price Range:</div>
              <input name="priceLowInput" type="number" onChange={handleChange} /> to
              <input name="priceHighInput" type="number" onChange={handleChange} />
            </div>
          </fieldset>

        </div>
      </div>
    </>
  )
}

export default Tools
