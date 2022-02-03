import React from 'react';
import { Card, Button } from 'react-bootstrap';
import { useGame } from '../contexts/gameContexts'

function CardsComponent(){ 

    const { setValue, returnValue , returnAllValues }  = useGame()
    const values = returnAllValues()
    const selected = returnValue()
    


    return(
        <>
        <div
            style={{
            display:"grid", 
            gridTemplateColumns: "repeat(auto-fill,minmax(320px,1fr))",   
            alignItems: "flex-start",
            gap: 20}}
            className='m-2'>
        {
            
            values.map((radio, idx) => {
            return (
                <Card 
                    key={idx}
                    onClick={() => setValue(radio.value)}
                    style = {{cursor: "pointer"}} 
                    className={selected === radio.value ? 'bg-secondary' : 'bg-light'}>
                    <Card.Body>
                        <Card.Title className='mt-4 align-items-baseline'>
                            <h1>
                                {radio.emoji}
                            </h1>
                            <h2>
                                {radio.name}
                            </h2>
                        </Card.Title>                            
                    </Card.Body>
                </Card> 
            )})
            
        }   
        </div>  
        <div className='d-flex justify-content-start m-2'>
            <Button size="lg" variant = "primary">
                Submit
            </Button>
        </div>
    </>
    );
};

export default CardsComponent;




