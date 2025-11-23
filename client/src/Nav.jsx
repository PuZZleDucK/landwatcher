import reactLogo from './assets/react.svg'
import UserInfo from './UserInfo.jsx'
import './Nav.css'
function Nav() {

  return (
    <>
      <div className="navbar">
        <img src={reactLogo} className="logo react" alt="React logo" />
        <h1>LandWatcher</h1>
        <UserInfo />
      </div>
    </>
  )
}

export default Nav
