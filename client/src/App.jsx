import { useState ,useEffect} from 'react'
import './App.css'
import { ethers } from 'hardhat'
import Modal from './components/Modal.jsx'
import Display from './components/Display.jsx'
import FileUpload from './components/FileUpload.jsx'
import Lock from './components/Lock.json'


function App() {
  const [account,setAccount]=useState("")
  const [provider,setProvider]=useState(null)
  const [contract,setContract]=useState(null)
  const [modalopen,setModalOpen]=useState(false)

  useEffect(()=>{
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const loadProvider=async()=>{
      if(provider){
        await provider.send("eth_requestAccounts",[]);
        const signer=provider.getSigner();
        const address =await signer.getAddress();
        setAccount(address);
        let contractAddress=""
        const contract=new ethers.Contract(
          contractAddress,Lock,signer
        );
        console.log(contract);
        setContract(contract);
        setProvider(provider);
      }
      else{
        console.error("mm not installed");
      }
    };
    provider && loadProvider()
  },[]);

  return (
    <div className="App">

    </div>
  )
}

export default App;
