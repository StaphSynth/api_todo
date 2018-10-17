import { createStore } from redux;
import TasksReducer from '../reducers/root';

const setupStore = (railsProps) => (
  createStore(TasksReducer, railsProps)
);

export default setupStore;