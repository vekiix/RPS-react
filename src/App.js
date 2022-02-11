import { Container, Stack} from 'react-bootstrap';
import Navbar from './components/navbarComponent';
import AddressComponent from './components/adressComponent';
import CardsComponent from './components/cardsComponent';
import { useGame } from './contexts/gameContexts';
import web3Context from './contexts/web3Context';

function App() {
  const {isAddressValid} = useGame()
  const validAddress = isAddressValid()
  console.log(web3Context.version);
  return (
  <>
  <Navbar />
  <Container>
    <Stack direction='vertical' gap="2" className='mt-4'>
      <AddressComponent />
      {validAddress ? <CardsComponent />: null}
    </Stack>
  </Container>
  </>
  )
};

export default App;
