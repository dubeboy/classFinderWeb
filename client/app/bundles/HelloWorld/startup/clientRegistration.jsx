import ReactOnRails from 'react-on-rails';
import HelloWorldApp from './HelloWorldAppClient';
import MyApp from '../containers/MyContainer'

// This is how react_on_rails can see the HelloWorldApp in the browser.
ReactOnRails.register({ HelloWorldApp });
ReactOnRails.register({ MyApp });