import * as React from 'react';
import { render } from '@testing-library/react';

import App from './App';

describe('App', () => {
  it('renders App and contains LandWatcher text', () => {
    let app = render(<App />);
    expect(app.container.innerHTML).toMatch('LandWatcher');
  });
});
