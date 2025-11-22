import { useEffect, useState } from 'react'
import './Listings.css'
import Listing from './Listing';

function Listings() {
  const [data, setData] = useState([]);
  useEffect(() => {
  fetch('http://localhost:3001/properties')
    .then((data) => {
      const textData = data.text();
      textData.then(resolvedText => {
        setData(JSON.parse(resolvedText));
      });
    });
  }, [])

  return (
    <>
      <div className="listings">
        <h4>Listing Results:</h4>
        <div className="listingTable">
          <table>
            <thead>
              <tr>
                <th className="listingCell">ID</th>
                <th className="listingCell">Type</th>
                <th className="listingCell">Rooms</th>
                <th className="listingCell">Price</th>
              </tr>
            </thead>
            <tbody>
              {data.map((item) => (
                <Listing key={item.id} id={item.id} name={item.title} rooms={item.bedrooms} price={item.price} />
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </>
  )
}

export default Listings
