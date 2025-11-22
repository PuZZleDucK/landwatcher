import reactLogo from './assets/react.svg'
import './Listings.css'
function Listings() {

  return (
    <>
      <div className="listings">
        <h4>Listing Results:</h4>
        <div className="listingTable">
          <table>
            <tr>
              <th className="listingCell">ID</th>
              <th className="listingCell">Type</th>
              <th className="listingCell">Rooms</th>
              <th className="listingCell">Price</th>
            </tr>
            <tr>
              <td className="listingCell">1</td>
              <td className="listingCell">filler House</td>
              <td className="listingCell">3</td>
              <td className="listingCell">$250,000</td>
            </tr>
            <tr>
              <td className="listingCell">2</td>
              <td className="listingCell">filler Flat</td>
              <td className="listingCell">2</td>
              <td className="listingCell">$150,000</td>
            </tr>
          </table>
        </div>
    
      </div>
    </>
  )
}

export default Listings
