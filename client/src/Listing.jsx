import { useEffect, useState } from 'react'
import './Listing.css'
function Listing({id, name, rooms, price}) {

  return (
    <>
      <tr className="listingRow" id={`listing${id}`}>
        <td className="listingCell">{id}</td>
        <td className="listingCell">{name}</td>
        <td className="listingCell">{rooms}</td>
        <td className="listingCell">{price}</td>
      </tr>
    </>
  )
}

export default Listing
