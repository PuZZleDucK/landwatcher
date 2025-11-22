import reactLogo from './assets/react.svg'
import './Tools.css'
function Tools() {

  return (
    <>
      <div className="tools">
        <h4>Listing Tools:</h4>
        <div className="search">
          <fieldset>
            <legend>Search</legend>
            <button>🗙</button>
            <input name="searchInput" />
          </fieldset>
        </div>
    
        <div className="filters">
          <fieldset>
            <legend>Filters</legend>
            <div>Rooms: <input name="bedroomsInput" type="number" /></div>
            <div>Type: <select namde="typeSelect">
              <option value="any">Any</option>
              <option value="house">House</option>
              <option value="flat">Flat</option>
            </select></div>
            <div>
              <div>Price Range:</div>
              <input name="priceLowInput" type="number" /> to
              <input name="priceHighInput" type="number" />
            </div>
          </fieldset>

        </div>
      </div>
    </>
  )
}

export default Tools
