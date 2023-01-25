import {useEffect, useMemo, useState} from 'react';
import { AddressZero } from '@ethersproject/constants';//0x0
import { useWeb3React } from '@web3-react/core';
import Web3 from "web3";

export function useContract(contractJson) {
  const [address, setAddress] = useState(AddressZero);//0x0000000
  const [instance, setInstance] = useState();
  const [error, setError] = useState('');
  const { library, account, chainId } = useWeb3React();
  const signerOrProvider = account ? library?.givenProvider.selectedAddress : library;

  useEffect(() => {
    const {ethereum} = window
    const web3 = new Web3(ethereum);

    web3.eth.net.getId().then(networkId => {
      const _address = contractJson.networks[networkId]?.address;
      
      if (_address) {
        setAddress(_address)
        console.log(address)
        setInstance(new web3.eth.Contract(contractJson.abi, _address));
      } else {
        setError('No contract found')
        setAddress('');
        setInstance(undefined);
      }
    })

  }, [contractJson, chainId])


  return useMemo(() => {
    return {
      contract: instance,
      address,
      error
    };
  }, [address, contractJson, signerOrProvider, instance]);
}