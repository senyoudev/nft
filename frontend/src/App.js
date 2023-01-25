import './App.css';
import { injected } from './utils/connector';
import { useWeb3React } from '@web3-react/core';
import { useEffect, useState } from 'react';
import { useContract } from './hooks/useContract';
import CodeMavricksNFTs from './contracts/CodeMavricksNFTs.json'

const GAS_AMOUNT = 3000000;

function App() {

  const [address,setAddress] = useState("")
  const contract = useContract(CodeMavricksNFTs)

  const {activate,account} = useWeb3React()


  useEffect(()=> {
    activate(injected)
  },[])

  const mintNFT = async(e) => {
    e.preventDefault()
    try {
        await contract?.contract?.methods.mint(address).send({from:account,gas:GAS_AMOUNT})
    } catch (error) {
      console.log(error)
    }
  }
 

  return (
    <div>
      <div className="container">
        <h1>Nft Minter</h1>
        <img src="./mainImage.png" />
        <form>
          <div className="form-group">
            <label htmlFor="address">Recipient's Address </label>
            <input type="text" placeholder="Recipient's Address" value={address} onChange={(e) => setAddress(e.target.value)}/>
          </div>
          <button onClick={mintNFT}>Let's Mint</button>
        </form>
      </div>
    </div>
  );
}

export default App;
