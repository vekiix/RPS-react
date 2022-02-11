import React from 'react';
import { Navbar,Container } from 'react-bootstrap';



function navbar(){
    return(
    <Navbar bg="dark" variant="dark">
        <Container>
            <Navbar.Brand href="">
                <h2>ROCK PAPER SCISSORS .eth</h2>
            </Navbar.Brand>    
        </Container>
    </Navbar>
    );
};

export default navbar;

