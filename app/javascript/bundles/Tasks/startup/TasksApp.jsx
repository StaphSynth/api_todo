import React from 'react';
import { Provider } from 'react-redux';

import setupStore from '../store/store';
import TasksContainer from '../containers/TasksContainer';

const TasksApp = (props) => (
  <Provider store={ setupStore(props) }>
    <TasksContainer />
  </Provider>
);

export default TasksApp;
