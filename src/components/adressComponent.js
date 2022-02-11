import React, { useRef } from 'react';
import { Form,Card, Button }  from 'react-bootstrap';
import { useGame } from '../contexts/gameContexts'

function AddressComponent(){
    const addressRef = useRef("");
    const { setAddressValue, returnAddress,isAddressValid } = useGame()
    const addr = returnAddress()
    const valid = isAddressValid()
    const STATUS = [{name : 'confirmed', emoji: '✅'},{name : 'denied', emoji: '🚫'}]


    return(
    <Form>
        <Card className= {"m-2"} border={valid ? "success ":"danger"}>
          <Card.Body>
            <Card.Title className='d-flex m-1 text-muted'>
                <Form.Label>
                    Contract address:
                </Form.Label>
            </Card.Title>
            <Form.Control placeholder="Enter address..." ref={addressRef} type='text' required/>
            <div className='d-flex justify-content-end mt-4'>
                <Button 
                onClick={() => {
                     setAddressValue(addressRef.current.value)     
                }}
                variant='primary'>
                    Add
                </Button>
            </div>
            <div className='d-flex justify-content-end mt-2'>
                <h5 className='text-muted'>{valid ? addr: "" }  {valid ? STATUS[0].emoji:STATUS[1].emoji} </h5>
            </div>
          </Card.Body>
        </Card>    
    </Form>
    );
};

export default AddressComponent;




