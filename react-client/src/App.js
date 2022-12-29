import './App.css';
import { useEffect, useState } from 'react';
import axios from 'axios';

const URL = "./backend/"

function App() {

  const [loggedUser, setLoggedUser] = useState(null);

  useEffect(()=>{
    axios.post(URL+"rest.login.php", {}, {withCredentials:true})
    .then(resp => setLoggedUser(resp.data))
    .catch(e => console.log(e.message));

  }, []);
  return (

    <div>
      {loggedUser && <button type="button" onClick={logout}>Kirjaudu ulos</button>}
      {loggedUser ?  <UserPage uname={loggedUser}/> : <Login setLoggedUser={setLoggedUser}/>}

    </div>
  );

  function logout(){
    axios.get(URL+"rest_logout.php", {withCredentials:true})
    .then(resp => setLoggedUser(null))
    .catch(e => console.log(e.message));
  }
}

function Login({setLoggedUser}) {
  const [uname, setUname] = useState("");
  const [pw, setPw] = useState("");

  function logIn(){
    const formData = new FormData();
    formData.append("uname", uname);
    formData.append("pw", pw);

    axios.post(URL+"rest.login.php", formData, {withCredentials:true})
    .then(resp => setLoggedUser(resp.data))
    .catch(e=>console.log(e.message))
  }

  return (
    <form>
      <label>Käyttäjänimi:</label>
      <input type="text" value={uname} onChange={e=>setUname(e.target.value)}></input><br/>
      <label>Salasana:</label>
      <input type="password" value={pw} onChange={e=>setPw(e.target.value)}></input>
      <button type="button" onClick={logIn}>Kirjaudu</button>

    </form>
  )
}

function UserPage({uname}){
  const [messages, setMessages] = useState([]);

  useEffect(()=>{
    axios.get(URL+"rest_user_info.php", {withCredentials:true})
      .then(resp=> setMessages(resp.data.messages))
      .catch(e=>console.log(e.message))


  }, []);

  return(
    <div>
      <h1>Tervetuloa {uname}. Viestisi:</h1>
      <ul>
        {messages.map((msg,i)=> <li key={"a"+i}>{msg}</li>)}
      </ul>
    </div>
  )
}



export default App;
