import React, {useContext, useState} from "react";

const GameContext = React.createContext()

export function useGame() {
    return useContext(GameContext)
}

export const GameProvider = ({children})  => {
    const [chosenValue, setChosenValue] = useState('0')
    const [address, setAddress] = useState("")

    const options = [
                        {name: 'Rock',emoji: '✊', value: '0'},
                        {name: 'Paper',emoji: '✋', value: '1'},
                        {name: 'Scissors',emoji: '✌', value: '2'}
                    ] 

    function setAddressValue(address) {
        setAddress(value => value = address)
    }

    function returnAddress(){
        return address
    }

    function isAddressValid(){
        return address.length === 42 && address.slice(0,2) === '0x'
    }

    function returnAllValues(){
        return [...options]
    }
    
    function returnValue() {
        return chosenValue
    }
    function setValue (id) {
        setChosenValue(value =>value = id)
    }

    return (
        <GameContext.Provider 
        value = {{
            returnValue,
            setValue,
            returnAllValues,
            returnAddress,
            isAddressValid,
            setAddressValue 
        }}>
            {children}
        </GameContext.Provider>
        
    )

}
