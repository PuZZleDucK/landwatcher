import reactLogo from './assets/react.svg'
import './Nav.css'
function Nav() {

  return (
    <>
      <div className="navbar">
        <img src={reactLogo} className="logo react" alt="React logo" />
        <h1>LandWatcher</h1>
        <div>User: Placeholder</div>
      </div>
    </>
  )
}

export default Nav
