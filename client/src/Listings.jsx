import { useEffect, useState } from 'react'
import InfiniteScroll from 'react-infinite-scroller';
import './Listings.css'
import Listing from './Listing';

function Listings( { filters } ) {
  const [data, setData] = useState([]);
  const [more, setMore] = useState(true);
  
  useEffect(() => {
    fetch(`http://localhost:3001/properties?page=1&per_page=5&price_floor=${filters.priceLowInput || 0}&price_ceiling=${filters.priceHighInput || 10000000}`)
      .then((data) => {
        const textData = data.text();
        textData.then(resolvedText => {
          setData(JSON.parse(resolvedText));
        });
      });
  }, [])
  const loadMoreData = (page) => {
    fetch(`http://localhost:3001/properties?page=${page}&per_page=5&price_floor=${filters.priceLowInput || 0}&price_ceiling=${filters.priceHighInput || 10000000}`)
      .then((newData) => {
        const textData = newData.text();
        textData.then(resolvedText => {
          const newJson = JSON.parse(resolvedText);
          if (newJson.length === 0) {
            setMore(false);
            return;
          }
          setData(data.concat(newJson));
        });
      });
  };

  return (
    <>
      <div className="listings">
        {/* <h4>Filters debug:</h4>
        <pre>{JSON.stringify(filters, null, 2)}</pre>
        <span>filters.priceLowInput: {filters.priceLowInput}</span>
        <span>filters.priceHighInput: {filters.priceHighInput}</span>
        <span>filters.bedroomsInput: {filters.bedroomsInput}</span>
        <span>filters.typeSelect: {filters.typeSelect}</span>
        <span>filters.searchInput: {filters.searchInput}</span> */}
        <h4>Listing Results ({data.length}):</h4>
        <div className="listingTable" style={{height:700, overflow:'auto'}}>

          <InfiniteScroll
              pageStart={1}
              loadMore={loadMoreData}
              hasMore={more}
              loader={<div className="loader" key={0}>Loading ...</div>}
              useWindow={false}
          >
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
          </InfiniteScroll>
        </div>
      </div>
    </>
  )
}

export default Listings
