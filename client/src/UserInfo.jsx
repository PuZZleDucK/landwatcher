import React, { Component, use, useState } from 'react'
import './UserInfo.css';

class UserInfo extends Component {
    handleSubmit = (event) => {
      event.preventDefault()
      const formData = new FormData(event.target);
      const email = formData.get("email");
      const password = formData.get("password");

      // setup state to update to force re-render
      // updated the date and rerenderd that but
      // not the updated border color :(
      // directly setting borderColor did not work either
      // had it workded the plan was to flip to the user
      // display with a logout button after successful login
      this.setState({ nonUsedKey: Date.now() });
      this.setState({ borderColor: 'black' });
      fetch('http://localhost:3001/login', {
        method: 'POST',
        body: JSON.stringify({user: {email: email, password: password}}),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      }).then(function(response) {
        console.log(response.status)
        console.log(response.headers)
        // not sure why the authorization header is not accessible here
        // the status is 200 for good credentials so devise should have set it
        if (response.status !== 200) {
          localStorage.setItem("loginStatus", "red");
          this.setState({ nonUsedKey: Date.now() });
          this.setState({ borderColor: 'red' });
          throw new Error('Login failed');
        } else {
          console.log('Login successful');
          localStorage.setItem("loginStatus", "green");
          this.setState({ nonUsedKey: Date.now() });
          this.setState({ borderColor: 'green' });
          // would also store the JWT token from header here
          // to include in future requests
        }
      });
    }
  
    render(){
      return (
        <>
          <div className="user_info" key={this.state ? this.state.nonUsedKey : "initial"}>
            <fieldset style={{borderColor: this.state ? this.state.borderColor : "black"}}>
              <legend>User Login</legend>
              <form className="login-form" onSubmit={this.handleSubmit}>
                <div className="login-fields">
                  <input name="email" />
                  <input name="password" type="password" />
                </div>
                <button type="submit" className='login-button'>Login</button>
              </form>
            </fieldset>

            {/* <fieldset>
              <legend>User Logged in</legend>
              <div className="login-form">
                <div className="login-fields">
                  <span>Email: REX</span>
                  <span>1 watched property</span>
                </div>
                <button className='login-button'>Logout</button>
              </div>
            </fieldset> */}

          </div>
        </>

      )
    }
}

export default UserInfo
  














// import { useFormStatus } from "react-dom";
// import { use, useEffect, useState } from 'react'
// import React, { Component } from 'react'
// import './UserInfo.css'
// function UserInfo() {

//   this.handleSubmit = this.handleSubmit.bind(this);
//   handleSubmit = (e) => {
//     e.preventDefault();
//     console.log(e);

//     const body = e.target.body.value;

//     // fetch("http://localhost:3001/comments", {
//     //   method: "POST",
//     //   body: JSON.stringify(body)
//     // }).then((response) => {
//     //   console.log(response);
//     //   return response.json(); // do something with response JSON
//     // });
//   };



//   // const [username, setUsername] = useState('');
//   // useEffect(() => {
//   //   // set username from form
//   //   setUsername(formData.get("username"));
//   // }, [])
//   // const [password, setPassword] = useState('');
//   // useEffect(() => {
//   //   setPassword(formData.get("password"));
//   // }, [])

//   const [user, setUser] = useState('');
//   const [username, setUsername] = useState('REX');
//   const [password, setPassword] = useState('password');



//   const login = (formData) => {
//     const username = formData.get("username");
//     const password = formData.get("password");
//     console.log("Logging in with2", username);
//   };








//   // useEffect(function login() {
//   //   console.log("Logging in");
//   //   console.log("Logging in with", username);
//   // }, [])



//   const { pending } = useFormStatus();
//   // this.handleSubmit = this.handleSubmit.bind(this);
//   // handleSubmit((event) => {
//   //   alert('A name was submitted: ' + this.state.username);
//   //   event.preventDefault();
//   // })

//   // // breaks the rule of hooks?
//   // function login(formData) {
//   //   const username = formData.get("username");
//   //   const password = formData.get("password");
//   //   console.log("Logging in with", username);
//   //   // ok, have username and password
//   //   // fetch devise login and verify in rails and return user info
//   //   useEffect(() => {
//   //   fetch('http://localhost:3001/login')
//   //     .then((data) => {
//   //       const textData = data.text();
//   //       textData.then(resolvedText => {
//   //         setData(JSON.parse(resolvedText));
//   //       });
//   //     });
//   //   }, [])
//   // }

//   return (
//     <>
//       <div className="user_info">
//         <fieldset>
//           <legend>User Login</legend>
//           <form className="login-form" action={this.handleSubmit}>
//             <div className="login-fields">
//               <input name="username" />
//               <input name="password" type="password" />
//             </div>
//             <button type="submit" className='login-button' disabled={pending}>{pending ? "Logging in..." : "Login"}</button>
//           </form>
//         </fieldset>

//         {/* <fieldset>
//           <legend>User Logged in</legend>
//           <div className="login-form">
//             <div className="login-fields">
//               <span>Username: REX</span>
//               <span>1 watched property</span>
//             </div>
//             <button className='login-button'>Logout</button>
//           </div>
//         </fieldset> */}

//       </div>
//     </>
//   )
// }

// export default UserInfo
